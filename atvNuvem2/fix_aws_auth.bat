@echo off
echo ========================================
echo Corrigindo aws-auth ConfigMap do EKS
echo ========================================

echo.
echo 1. Obtendo ARN do usuário atual...
for /f "tokens=*" %%i in ('aws sts get-caller-identity --query "Arn" --output text') do set USER_ARN=%%i
echo Usuario ARN: %USER_ARN%

echo.
echo 2. Obtendo aws-auth ConfigMap atual...
kubectl get configmap aws-auth -n kube-system -o yaml > aws-auth-backup.yaml
echo Backup salvo em: aws-auth-backup.yaml

echo.
echo 3. Verificando se o usuario ja esta no ConfigMap...
findstr /C:"%USER_ARN%" aws-auth-backup.yaml
if %errorlevel% equ 0 (
    echo Usuario ja esta no ConfigMap!
    goto :end
)

echo.
echo 4. Adicionando usuario ao aws-auth ConfigMap...
kubectl patch configmap aws-auth -n kube-system --patch "{\"data\":{\"mapUsers\":\"- userarn: %USER_ARN%\n  username: asn20252\n  groups:\n  - system:masters\n\"}}"

echo.
echo 5. Verificando se a alteracao foi aplicada...
kubectl get configmap aws-auth -n kube-system -o yaml

echo.
echo 6. Testando conectividade...
kubectl cluster-info

:end
echo.
echo Processo concluido!
pause
