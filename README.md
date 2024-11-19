# Terraform Configuration for Oracle Kubernetes Engine (OKE) on Oracle Cloud Infrastructure (OCI)

Este repositório contém um exemplo de configuração Terraform para provisionar um cluster OKE (Oracle Kubernetes Engine) na Oracle Cloud Infrastructure (OCI). O código configura o cluster, as sub-redes necessárias, gateways de rede, tabelas de rotas e listas de segurança.

## Estrutura dos Arquivos

- **gateway.tf**: Configura o Internet Gateway, NAT Gateway e Service Gateway para o Virtual Cloud Network (VCN).
- **nodepool.tf**: Cria um Node Pool no cluster OKE, configurando o tamanho, forma e a imagem do sistema operacional para os nós de trabalho.
- **oke_cluster.tf**: Provisiona o cluster OKE, configurando a versão do Kubernetes, sub-redes e opções específicas.
- **outputs.tf**: Define saídas importantes, como o ID do VCN, ID do cluster OKE e ID do Node Pool.
- **provider.tf**: Configura o provedor OCI.
- **route_tables.tf**: Define tabelas de rotas para o tráfego de rede, incluindo regras para comunicação com a internet e serviços OCI.
- **security_lists.tf**: Configura listas de segurança para as sub-redes, definindo regras de entrada e saída.
- **subnets.tf**: Cria subnets para os nós de trabalho, o ponto de API Kubernetes e os load balancers de serviço.
- **variables.tf**: Define variáveis que são usadas para parametrizar a configuração do Terraform.
- **vcn.tf**: Cria o Virtual Cloud Network (VCN) para o cluster OKE.

## Pré-requisitos

Antes de executar esta configuração Terraform, certifique-se de ter:

1. Uma conta OCI com as permissões adequadas para criar recursos.
2. A CLI da OCI instalada e configurada.
3. O Terraform instalado na sua máquina.

## Como Usar

1. **Clone este repositório**:
   ```bash
   git clone https://github.com/seu-repositorio/terraform-oci-oke.git
   cd terraform-oci-oke
   ```

2. **Atualize o arquivo `variables.tf`** com as informações do seu ambiente:
   - `tenancy_ocid`: O OCID do seu tenancy.
   - `compartment_id`: O OCID do compartment onde os recursos serão criados.
   - `user_ocid`: O OCID do seu usuário.
   - `region`: A região OCI desejada.
   - `availability_domain`: O domínio de disponibilidade desejado.
   - `cluster_name`: Um nome exclusivo para o cluster.
   - `dns_name`: Um rótulo DNS válido (apenas letras, de 1 a 15 caracteres).

3. **Inicialize o Terraform**:
   ```bash
   terraform init
   ```

4. **Visualize o plano de execução**:
   ```bash
   terraform plan
   ```

5. **Aplique o plano para provisionar os recursos**:
   ```bash
   terraform apply
   ```
   Confirme a criação dos recursos digitando `yes` quando solicitado.

## Saídas

O Terraform gerará as seguintes saídas:

- `vcn_id`: O OCID do Virtual Cloud Network criado.
- `oke_cluster_id`: O OCID do cluster OKE criado.
- `node_pool_id`: O OCID do Node Pool criado.

## Acesso ao cluster

Para acessar o Cluster com Kubernetes:

- Acesse o console da OCI;
- Acesse a aba de "Containers" > "Cluster" > "${Seu_Cluster}" > "Access Cluster"
- Aqui possuimos duas opções: Local Access e Shell access. Escolha a preferida por você.

## Atenção em aplicações

ATENÇÃO: Para que as aplicações consigam acessar o Kubernetes, precisamos de um secrets específico.
         Este secret será responsável pelas credenciais de permissionamento da OCI entre Aplicação e Kubernetes.

- Se você fizer parte da oracleindentitycloudservice:

```bash
kubectl create secret docker-registry ocirsecret --docker-server=gru.ocir.io --docker-username={compartment}/oracleidentitycloudservice/{usuário} docker-password='{Auth_Token}' --docker-email={Seu_Email}
```

- Se você NÃO fizer parte da oracleindentitycloudservice:

```bash
kubectl create secret docker-registry ocirsecret --docker-server=gru.ocir.io --docker-username={compartment}/{usuário} docker-password='{Auth_Token}' --docker-email={Seu_Email}
```

Além disso, no arquivo YAML de deployment da sua aplicação, precisa constar o secrets

```bash
imagePullSecrets:
    - name: ocirsecret
```

## Limpeza de Recursos

Para remover todos os recursos criados pelo Terraform, execute:
```bash
terraform destroy
```
Confirme a destruição digitando `yes` quando solicitado.

## Considerações Importantes

- **Custos**: Os recursos criados por esta configuração podem gerar custos na sua conta OCI. Certifique-se de monitorar o uso e os custos associados.
- **Segurança**: Certifique-se de revisar e ajustar as regras de segurança nas listas de segurança para atender às necessidades específicas do seu ambiente.

