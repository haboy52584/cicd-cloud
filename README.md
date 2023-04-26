1. Initialize Terraform:

   In the `terraform/` directory, run:

   ```
   terraform init
   ```

2. Apply Terraform configuration:

   In the `terraform/` directory, run:

   ```
   terraform apply
   ```

   Review the infrastructure changes, and type `yes` to confirm and apply the changes. Terraform will provision the resources and output the front-end URL once the process is complete.

3. Configure inventory file:

   Update the `ansible/inventory.ini` file with the public IP addresses of the front-end and back-end instances. You can obtain these from your AWS EC2 dashboard.

4. Run the Ansible playbook:

   In the `ansible/` directory, run:

   ```
   ansible-playbook -i inventory.ini playbook.yml
   ```

5. Apply Chef cookbook:

   First, install Chef Workstation on your local machine following the instructions here: https://downloads.chef.io/tools/workstation

   Then, SSH into the back-end instance and install Chef:

   ```
   curl -L https://omnitruck.chef.io/install.sh | sudo bash
   ```

   Now, copy the `chef/` directory to the back-end instance using `scp`:

   ```
   scp -r chef/ ubuntu@BACKEND_INSTANCE_IP:/home/ubuntu/
   ```

   SSH into the back-end instance and apply the Chef cookbook:

   ```
   sudo chef-solo -c /home/ubuntu/chef/solo.rb
   ```

6. Test the front-end URL:

   After successfully running the Ansible playbook and Chef cookbook, you can test the front-end URL provided by Terraform. Copy the URL and paste it into your web browser to access the sample application.

Remember to replace the placeholders, such as `YOUR_FRONTEND_INSTANCE_IP` and `YOUR_BACKEND_INSTANCE_IP`, with the actual IP addresses of the instances.

When you're done testing and want to destroy the infrastructure, run the following command in the `terraform/` directory:

```
terraform destroy
```

Review the resources to be destroyed, and type `yes` to confirm and destroy the infrastructure.
