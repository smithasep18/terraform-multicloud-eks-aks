pipeline {
    agent any

    parameters {
        choice(name: 'ACTION', choices: ['PLAN', 'APPLY', 'DESTROY'], description: 'Choose Terraform action')
    }

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/smithasep18/terraform-multicloud-eks-aks.git'
            }
        }

        stage('Tool Versions') {
            steps {
                sh 'terraform version'
                sh 'aws --version'
                sh 'az version'
                sh 'aws sts get-caller-identity'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'TF_VAR_azure_client_id'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'TF_VAR_azure_client_secret'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'TF_VAR_azure_tenant_id'),
                    string(credentialsId: 'AZURE_SUBSCRIPTION_ID', variable: 'TF_VAR_azure_subscription_id')
                ]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'TF_VAR_azure_client_id'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'TF_VAR_azure_client_secret'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'TF_VAR_azure_tenant_id'),
                    string(credentialsId: 'AZURE_SUBSCRIPTION_ID', variable: 'TF_VAR_azure_subscription_id')
                ]) {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            when {
                anyOf {
                    expression { params.ACTION == 'PLAN' }
                    expression { params.ACTION == 'APPLY' }
                }
            }
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'TF_VAR_azure_client_id'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'TF_VAR_azure_client_secret'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'TF_VAR_azure_tenant_id'),
                    string(credentialsId: 'AZURE_SUBSCRIPTION_ID', variable: 'TF_VAR_azure_subscription_id')
                ]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Approval for Apply') {
            when {
                expression { params.ACTION == 'APPLY' }
            }
            steps {
                input message: 'Proceed with terraform apply?'
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'APPLY' }
            }
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'TF_VAR_azure_client_id'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'TF_VAR_azure_client_secret'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'TF_VAR_azure_tenant_id'),
                    string(credentialsId: 'AZURE_SUBSCRIPTION_ID', variable: 'TF_VAR_azure_subscription_id')
                ]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Approval for Destroy') {
            when {
                expression { params.ACTION == 'DESTROY' }
            }
            steps {
                input message: 'Proceed with terraform destroy?'
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'DESTROY' }
            }
            steps {
                withCredentials([
                    string(credentialsId: 'AZURE_CLIENT_ID', variable: 'TF_VAR_azure_client_id'),
                    string(credentialsId: 'AZURE_CLIENT_SECRET', variable: 'TF_VAR_azure_client_secret'),
                    string(credentialsId: 'AZURE_TENANT_ID', variable: 'TF_VAR_azure_tenant_id'),
                    string(credentialsId: 'AZURE_SUBSCRIPTION_ID', variable: 'TF_VAR_azure_subscription_id')
                ]) {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}