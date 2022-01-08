# terraform-aws-load-balancer
An opinionated module that creates an application load balancer with two listeners: one for http and one for https.

Subnets are required **
If you choose to create the listeners, you must pass in a certificate arn.

## Instantiation
The simplest instantiation requires only an `environment`, `subnets` and a `cert_arn` (if you want listeners created).

```
module "application_lb" {
  source = "git@github.com:kiawnna/terraform-aws-load-balancer.git"
  environment = "dev"
  subnets = ["subnet-id1", "subnet-id2"]
  cert_arn = "cert-arn"
}
```
> This example will create an external application load balancer and two listeners, one for http traffic and one for https.

---
Optionally, you could choose to exclude the creation of the listeners using the `create_listeners` variable.

```
module "application_lb" {
  source = "git@github.com:kiawnna/terraform-aws-load-balancer.git"
  environment = "dev"
  create_listeners = false
  subnets = ["subnet-id-1", "subnet-id-2"]
  security_groups = ["sg-id"]
}
```
> This example will create an application load balancer, external, without listeners. This will associate a security group with the
> load balancer as well.


## Resources Created
* A load balancer, which defaults to internet-facing and application
* By default, both a http and https listener (can optionally exclude by setting `create_listeners` to *false*).
* Optionally, a cookie stickiness policy for port 443 on the load balancer by setting `add_sticky_policy` to *true*.

## Outputs
The load balancer arn, id, dns name, zone id and arn suffix. If not set to false, the 443 listener arn will also be an output.

Reference them as:

> module.load_balancer_module_name.load_balancer_arn
> 
> module.load_balancer_module_name.load_balancer_id
> 
> module.load_balancer_module_name.lb_dns_name
> 
> module.load_balancer_module_name.lb_zone_id
> 
> module.load_balancer_module_name.load_balancer_arn_suffix
> 
> module.load_balancer_module_name.listener_443_arn

## Variables / Customization
The variable `create_listeners` has a default value of *true*. This will create two listeners for the load balancer, one for
port 80 and one for port 443.

The variable `add_stickY_policy` will add a sticky policy to the 443 listener. The default is *false*.

See the `variables.tf` file for further customizations.

## Tags
Tags are automatically added to all resources where possible. Tags will have the following format:

```
tags = {
    Name = "shared-${var.environment}-resource"
    Deployment_Method = "terraform"
    Environment = var.environment
  }
```

