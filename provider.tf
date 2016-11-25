# Configure the Packet Provider
provider "packet" {
        auth_token = "${var.auth_token}"
}

# Create a new SSH key
#resource "packet_ssh_key" "sshkey" {
#    name = "terraform-packet-ssh"
#    public_key = "${file("/Users/osvaldo/.ssh/packet.pub")}"
#}

