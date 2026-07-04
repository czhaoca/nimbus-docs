---
title: "nimbus az"
sidebar:
  order: 2
---

Manage Azure resources (az-mirrored grammar).

## Commands

### acr create

Create a container registry (mirrors `az acr create`).

Usage: `nimbus az acr create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Container registry name |
| `--sku` | text | no | `Basic` | Registry SKU: Basic\|Standard\|Premium |
| `--admin-enabled` | boolean | no | `False` | Enable the admin user (for credential show) |
| `--location`, `-l` | text | no | `eastus` | Azure region |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### acr credential show

Show registry admin credentials (mirrors `az acr credential show`). SENSITIVE.

Usage: `nimbus az acr credential show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name`, `-n` | text | yes | - | Container registry name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### acr delete

Delete a container registry (mirrors `az acr delete`).

Usage: `nimbus az acr delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Container registry name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### acr list

List container registries (mirrors `az acr list`).

Usage: `nimbus az acr list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### acr show

Show a container registry (mirrors `az acr show`).

Usage: `nimbus az acr show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Container registry name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### container create

Create a single-container group (mirrors `az container create`).

Usage: `nimbus az container create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Container group name |
| `--image` | text | yes | - | Container image reference |
| `--cpu` | float | no | `1.0` | CPU cores |
| `--memory` | float | no | `1.5` | Memory in GB |
| `--ports` | integer | no | - | Public ports (repeatable) |
| `--os-type` | text | no | `Linux` | OS type |
| `--restart-policy` | text | no | `Always` | Always\|OnFailure\|Never |
| `--environment-variables` | text | no | - | KEY=VALUE (repeatable) |
| `--location`, `-l` | text | no | `eastus` | Azure region |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### container delete

Delete a container group (mirrors `az container delete`).

Usage: `nimbus az container delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Container group name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### container list

List container groups (mirrors `az container list`).

Usage: `nimbus az container list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### container logs

Print a container's logs (mirrors `az container logs`).

Usage: `nimbus az container logs [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Container group name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### container show

Show a container group (mirrors `az container show`).

Usage: `nimbus az container show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Container group name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### context clear

Clear the active Azure provider context.

Usage: `nimbus az context clear [OPTIONS]`

_No options._

### context set

Set the active Azure provider context.

Usage: `nimbus az context set [OPTIONS] PROVIDER_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `provider_id` | text | yes | - | Azure provider ID to activate |

### context show

Show the current active Azure provider context.

Usage: `nimbus az context show [OPTIONS]`

_No options._

### cost current

Show Azure spending for the current or requested billing period.

Usage: `nimbus az cost current [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Azure provider ID |
| `--period` | text | no | - | Billing period in YYYY-MM format |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### disk create

Create an empty managed disk (mirrors `az disk create`).

Usage: `nimbus az disk create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Managed disk name |
| `--size-gb` | integer | yes | - | Disk size in GiB |
| `--location`, `-l` | text | no | `eastus` | Azure region |
| `--sku` | text | no | `Standard_LRS` | Disk SKU |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### disk delete

Delete a managed disk (mirrors `az disk delete`).

Usage: `nimbus az disk delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Managed disk name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### disk list

List managed disks (mirrors `az disk list`).

Usage: `nimbus az disk list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### freetier show

Show the current free tier spec for this provider.

Usage: `nimbus az freetier show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |

### network nsg create

Create a network security group (mirrors `az network nsg create`).

Usage: `nimbus az network nsg create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--location`, `-l` | text | no | `eastus` | Azure region |

### network nsg delete

Delete a network security group (mirrors `az network nsg delete`).

Usage: `nimbus az network nsg delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### network nsg list

List network security groups (mirrors `az network nsg list`).

Usage: `nimbus az network nsg list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### network nsg rule create

Create an NSG security rule (mirrors `az network nsg rule create`).

Usage: `nimbus az network nsg rule create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--nsg-name` | text | yes | - | Network security group name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--priority` | integer | yes | - | Rule priority (100-4096) |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--direction` | text | no | `Inbound` | Inbound\|Outbound |
| `--access` | text | no | `Allow` | Allow\|Deny |
| `--protocol` | text | no | `Tcp` | Tcp\|Udp\|Icmp\|* |
| `--destination-port-ranges` | text | no | `*` | Destination port(s), e.g. 22 |
| `--source-address-prefixes` | text | no | `*` | Source CIDR(s) or * |

### network nsg rule delete

Delete an NSG security rule (mirrors `az network nsg rule delete`).

Usage: `nimbus az network nsg rule delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--nsg-name` | text | yes | - | Network security group name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### network nsg rule list

List NSG security rules (mirrors `az network nsg rule list`).

Usage: `nimbus az network nsg rule list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--nsg-name` | text | yes | - | Network security group name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### network public-ip create

Create a public IP address (mirrors `az network public-ip create`).

Usage: `nimbus az network public-ip create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--location`, `-l` | text | no | `eastus` | Azure region |
| `--sku` | text | no | - | Basic\|Standard |

### network public-ip delete

Delete a public IP address (mirrors `az network public-ip delete`).

Usage: `nimbus az network public-ip delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### network public-ip list

List public IP addresses (mirrors `az network public-ip list`).

Usage: `nimbus az network public-ip list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### network vnet create

Create a virtual network (mirrors `az network vnet create`).

Usage: `nimbus az network vnet create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--address-prefixes` | text | yes | - | CIDR prefix(es), e.g. 10.x.0.0/16 |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--location`, `-l` | text | no | `eastus` | Azure region |
| `--subnet-name` | text | no | - | Optional embedded subnet name |
| `--subnet-prefixes` | text | no | - | Embedded subnet CIDR |

### network vnet delete

Delete a virtual network (mirrors `az network vnet delete`).

Usage: `nimbus az network vnet delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### network vnet list

List virtual networks (mirrors `az network vnet list`).

Usage: `nimbus az network vnet list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### network vnet show

Show a virtual network (mirrors `az network vnet show`).

Usage: `nimbus az network vnet show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### network vnet subnet create

Create a subnet (mirrors `az network vnet subnet create`).

Usage: `nimbus az network vnet subnet create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--vnet-name` | text | yes | - | Parent virtual network name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--address-prefixes` | text | yes | - | CIDR prefix(es), e.g. 10.x.0.0/16 |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### network vnet subnet delete

Delete a subnet (mirrors `az network vnet subnet delete`).

Usage: `nimbus az network vnet subnet delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--vnet-name` | text | yes | - | Parent virtual network name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### network vnet subnet list

List subnets in a vnet (mirrors `az network vnet subnet list`).

Usage: `nimbus az network vnet subnet list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--vnet-name` | text | yes | - | Parent virtual network name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### sql db create

Create a database (mirrors `az sql db create`).

Usage: `nimbus az sql db create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--server`, `-s` | text | yes | - | Parent SQL server name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--edition` | text | no | `GeneralPurpose` | Service tier, e.g. GeneralPurpose |
| `--compute-model` | text | no | `Serverless` | Provisioned\|Serverless |
| `--family` | text | no | `Gen5` | Hardware family, e.g. Gen5 |
| `--capacity` | integer | no | `2` | vCore capacity |
| `--use-free-limit` | boolean | no | `False` | Apply the always-free monthly limit |
| `--free-limit-exhaustion-behavior` | text | no | - | AutoPause\|BillOverUsage |
| `--auto-pause-delay` | integer | no | - | Minutes before auto-pause (-1 off) |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### sql db delete

Delete a database (mirrors `az sql db delete`).

Usage: `nimbus az sql db delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--server`, `-s` | text | yes | - | Parent SQL server name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### sql db list

List databases on a server (mirrors `az sql db list`).

Usage: `nimbus az sql db list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--server`, `-s` | text | yes | - | Parent SQL server name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### sql db show

Show a single database (mirrors `az sql db show`).

Usage: `nimbus az sql db show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--server`, `-s` | text | yes | - | Parent SQL server name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### sql server create

Create a SQL logical server (mirrors `az sql server create`).

Usage: `nimbus az sql server create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--admin-user`, `-u` | text | yes | - | Server admin login |
| `--admin-password` | text | yes | - | Server admin password |
| `--location`, `-l` | text | no | `eastus` | Azure region |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### sql server delete

Delete a SQL server (mirrors `az sql server delete`).

Usage: `nimbus az sql server delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### sql server firewall-rule create

Create a server firewall rule (mirrors `az sql server firewall-rule create`).

Usage: `nimbus az sql server firewall-rule create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--server`, `-s` | text | yes | - | Parent SQL server name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--start-ip-address` | text | yes | - | Range start IP (user-supplied) |
| `--end-ip-address` | text | yes | - | Range end IP (user-supplied) |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### sql server firewall-rule list

List server firewall rules (mirrors `az sql server firewall-rule list`).

Usage: `nimbus az sql server firewall-rule list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--server`, `-s` | text | yes | - | Parent SQL server name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### sql server list

List SQL servers (mirrors `az sql server list`).

Usage: `nimbus az sql server list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### sql server show

Show a single SQL server (mirrors `az sql server show`).

Usage: `nimbus az sql server show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### storage account create

Create a storage account (mirrors `az storage account create`).

Usage: `nimbus az storage account create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--location`, `-l` | text | no | `eastus` | Azure region |
| `--sku` | text | no | `Standard_LRS` | Account SKU |
| `--kind` | text | no | `StorageV2` | Account kind |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### storage account delete

Delete a storage account (mirrors `az storage account delete`).

Usage: `nimbus az storage account delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### storage account list

List storage accounts (mirrors `az storage account list`).

Usage: `nimbus az storage account list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### storage blob delete

Delete a blob (mirrors `az storage blob delete`).

Usage: `nimbus az storage blob delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--account-name` | text | yes | - | Storage account name |
| `--container`, `-c` | text | yes | - | Container name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### storage blob download

Download a blob to a local path (mirrors `az storage blob download`).

Usage: `nimbus az storage blob download [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--account-name` | text | yes | - | Storage account name |
| `--container`, `-c` | text | yes | - | Container name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--file`, `-f` | text | yes | - | Local file path |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### storage blob list

List blobs in a container (mirrors `az storage blob list`).

Usage: `nimbus az storage blob list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--account-name` | text | yes | - | Storage account name |
| `--container`, `-c` | text | yes | - | Container name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### storage blob upload

Upload a local file as a blob (mirrors `az storage blob upload`).

Usage: `nimbus az storage blob upload [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--account-name` | text | yes | - | Storage account name |
| `--container`, `-c` | text | yes | - | Container name |
| `--file`, `-f` | text | yes | - | Local file path |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### storage container create

Create a container (mirrors `az storage container create`).

Usage: `nimbus az storage container create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--account-name` | text | yes | - | Storage account name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### storage container delete

Delete a container (mirrors `az storage container delete`).

Usage: `nimbus az storage container delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--account-name` | text | yes | - | Storage account name |
| `--name`, `-n` | text | yes | - | Resource name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### storage container list

List containers (mirrors `az storage container list`).

Usage: `nimbus az storage container list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--account-name` | text | yes | - | Storage account name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (-f/--format alias) |

### vm create

Create an Azure VM (mirrors `az vm create`). Provide --name or --label.

Usage: `nimbus az vm create [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--name`, `-n` | text | no | - | VM name (required if no --label) |
| `--label` | text | no | - | ICAO label. Expands via generate_name() into 'azure-{geo}-{type}-{label}'. |
| `--location`, `-l` | text | no | `eastus` | Azure region |
| `--size` | text | no | `Standard_B1s` | Azure VM size |

### vm deallocate

Deallocate (stop) an Azure VM (mirrors `az vm deallocate`).

Usage: `nimbus az vm deallocate [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | VM name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### vm delete

Delete an Azure VM (mirrors `az vm delete`).

Usage: `nimbus az vm delete [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | VM name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--yes`, `-y` | boolean | no | `False` | Skip confirmation (Azure-native --yes) |

### vm disk attach

Attach a managed disk to a VM (mirrors `az vm disk attach`).

Usage: `nimbus az vm disk attach [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--vm-name` | text | yes | - | Target VM name |
| `--name`, `-n` | text | yes | - | Managed disk name |
| `--lun` | integer | no | `0` | Logical unit number |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### vm disk detach

Detach a managed disk from a VM (mirrors `az vm disk detach`).

Usage: `nimbus az vm disk detach [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--vm-name` | text | yes | - | Target VM name |
| `--name`, `-n` | text | yes | - | Managed disk name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### vm list

List Azure virtual machines (mirrors `az vm list`).

Usage: `nimbus az vm list [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (Azure-native --output/-o; -f/--format Nimbus alias) |

### vm list-sizes

List available VM sizes in a location (mirrors `az vm list-sizes`).

Usage: `nimbus az vm list-sizes [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--location`, `-l` | text | yes | - | Azure region (required) |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (Azure-native --output/-o; -f/--format Nimbus alias) |

### vm restart

Restart an Azure VM (mirrors `az vm restart`).

Usage: `nimbus az vm restart [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | VM name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |

### vm show

Show an Azure VM by resource group + name (mirrors `az vm show`).

Usage: `nimbus az vm show [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | VM name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
| `--output`, `-o`, `-f`, `--format` | text | no | `table` | Output: table\|json (Azure-native --output/-o; -f/--format Nimbus alias) |

### vm start

Start an Azure VM (mirrors `az vm start`).

Usage: `nimbus az vm start [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--resource-group`, `-g` | text | yes | - | Azure resource group |
| `--name`, `-n` | text | yes | - | VM name |
| `--provider`, `-p` | text | no | - | Azure provider ID (nimbus extension) |
