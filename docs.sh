#!/usr/bin/bash
for d in $(stacks/terraform/aws/envs/**/**/*); do
  if [ -f "$d/main.tf" ]; then
    echo "Gerando docs para $d"
    terraform-docs markdown table "$d" > "$d/README.md"
  fi
done