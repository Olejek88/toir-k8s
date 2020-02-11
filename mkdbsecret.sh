#!/bin/bash
echo Making 'secret.yml'..

cat > secret.yml <<-ENDOF
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secrets
type: Opaque
data:
  ROOT_PASSWORD: $(echo -n "root8888" | base64)
ENDOF

echo Secret: $(echo -n "root8888" | base64)

