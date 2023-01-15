# Architecutre Diagram

![Alt text](./assets/1-architecture.png?raw=true "Architectre")

# Terraform deploy

First we need to clone the repository

```bash
$ git clone git@github.com:atiframzan89/demo-eks.git
```
All the basic configuration for terraform code can be changed from the `conf/dev.tfvars`
```
region = "us-east-1"
vpc = {
    #name = "vpc"
    cidr                    = "11.0.0.0/16"
    public_subnet           = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24" ]
    private_subnet          = ["11.0.4.0/24", "11.0.5.0/24", "11.0.6.0/24" ]
}
customer                    = "soum-test"
environment                 = "dev"
eks-instance-size           = "t2.medium"  
keypair                     = "aramzan-us-east-1"
s3-bucket-name              = "cat-devops-test"
```
The above the example values.

This terraform will create the following resources

* VPC
* Internet Gateway
* Public Subnet
* Private Subnet
* Nat Gateway
* Public and Private route table (Private route is connected to nateway)
* S3 bucket (Make s3 bucket public. VPC Endpoint is added with private route table as well)
* EKS Cluster (Nodes will be in the private)
* Security Groups
* Bastion Host (For Troubleshooting into eks node. It has public access on port 22)
* Add the helm provider (Only used for installing the aws loadbalancer controller but never used in for deploying the application)

Once you are done with changes of conf/dev.tfvars. Execute the terraform apply command as mentioned below

```bash
$ terraform validate
$ terraform plan
$ terraform apply --var-file=./config/dev.tfvars --auto-approve
```
It will take around 15 minutes to deploy the whole infrastructure. To connect with your eks cluster use the below command

```bash
aws eks --region us-east-1 update-kubeconfig --name <eks-cluster-name>
```

# Installing ArgoCD

After that we will be installing ArgoCD. Use the below command

```bash
$ kubectl create namespace argocd
$ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.5.6/manifests/install.yaml
```

Next you need to configure the service for argocd so that you can access it on the internet

```bash
$ kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```
You can get the service url from the below command

```bash
$ kubectl get svc 
```

Now to get the password for ARGOCD console

```bash
$ export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d` 
$ echo $ARGO_PWD
```
Now access the UI of ArgoCD on the browser and login with `admin` user followed the password using `echo $ARGO_PWD`

Now once you are sign in you need to connect your github repository. Goto settings repository and you need to set the below settings

![Alt text](./assets/2-argocd.png?raw=true "ArgoCD Github Connectivity")

Next you need click on three dots and select "Create an application"

![Alt text](./assets/3-argocd.png?raw=true "ArgoCD Github Connectivity")
![Alt text](./assets/4-argocd.png?raw=true "ArgoCD Github Connectivity")

It will deploy the application eks cluster. Now since our application requires AWS_ACCESS_KEY and AWS_SECRET_ACCESS_KEY, we need to deploy it manually by changing the secrets in app/soum-demo.yml file. Also we need to specify the AWS_BUCKET_NAME. 

Next we need to deploy the application, but first we need to remove it from the ArgoCD and then redploy using the below command.

```bash
$ kubectl apply -f app/soum-demo.yml
```
It will deploy the pod, service and secrets. After 2 to 3 minutes the svc name will be available with public dns.

```bash
$ kubectl get svc
NAME            TYPE           CLUSTER-IP     EXTERNAL-IP                                                               PORT(S)          AGE
kubernetes      ClusterIP      10.100.0.1     <none>                                                                    443/TCP          64m
soum-demo-svc   LoadBalancer   10.100.23.28   a4b0a08f0a3364f4c991428d5fd07960-1193304650.us-east-1.elb.amazonaws.com   5000:31780/TCP   7m39s
```

Access the app on public dns on port 5000 in the browser.

![Alt text](./assets/5-app.png?raw=true "ArgoCD Github Connectivity")

