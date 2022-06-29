/*# Create a Null Resource and Provisioners
resource "null_resource" "ssh_connection" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    #port        = 22
    host     = module.ec2_public.public_ip[0] 
    user     = "ubuntu"
    password = ""
    private_key = file("private-key/terraform-key.pem")
    #agent       = false
    #timeout     = "1m"
  }  


## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      # aws cli configuration
      "sudo su -",
      "aws s3 ls"
      
    ]
  }
}
*/