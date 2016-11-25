# type 0 server
resource "packet_device" "type00" {
        hostname = "type00"
        plan = "baremetal_0"
        facility = "ewr1"
        operating_system = "ubuntu_14_04_image"
        billing_cycle = "hourly"
        project_id = "${var.project_id}"

        provisioner "file" {
            source = "bin/install_type0.sh"
            destination = "/var/tmp/install.sh"
        }

        provisioner "remote-exec" {
            inline = [
              "chmod +x /var/tmp/install.sh",
              "/var/tmp/install.sh"
            ]
        }
}

# type 1 server
resource "packet_device" "type11" {
        hostname = "type11"
        plan = "baremetal_1"
        facility = "ewr1"
        operating_system = "ubuntu_14_04_image"
        billing_cycle = "hourly"
        project_id = "${var.project_id}"

        provisioner "file" {
            source = "bin/install_type1.sh"
            destination = "/var/tmp/install.sh"
        }

        provisioner "remote-exec" {
            inline = [
              "chmod +x /var/tmp/install.sh",
              "/var/tmp/install.sh"
            ]
        }
}
