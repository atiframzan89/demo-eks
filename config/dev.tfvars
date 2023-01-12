region = "us-west-2"
vpc = {
    #name = "vpc"
    cidr                    = "11.0.0.0/16"
    public_subnet           = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24" ]
    private_subnet          = ["11.0.4.0/24", "11.0.5.0/24", "11.0.6.0/24" ]
}
customer                    = "sequent"
environment                 = "dev"
eks-instance-size           = "t2.medium"  
keypair                     = "aramzan-oregon"