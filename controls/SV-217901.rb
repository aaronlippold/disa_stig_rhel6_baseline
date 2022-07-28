# encoding: UTF-8

control "SV-217901" do
  title "The system boot loader configuration file(s) must be owned by root."
  desc "Only root should be able to modify important boot parameters."
  desc "default", "Only root should be able to modify important boot parameters."
  desc "check", "To check the ownership of \"/boot/grub/grub.conf\", run the command: 

$ ls -lL /boot/grub/grub.conf

If properly configured, the output should indicate that the owner is \"root\".
If it does not, this is a finding."
  desc "fix", "The file \"/boot/grub/grub.conf\" should be owned by the \"root\" user to prevent destruction or modification of the file. To properly set the owner of \"/boot/grub/grub.conf\", run the command: 

# chown root /boot/grub/grub.conf"
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000480"
  tag gid: "V-217901"
  tag rid: "SV-217901r603264_rule"
  tag stig_id: "RHEL-06-000065"
  tag fix_id: "F-19380r376719_fix"
  tag cci: ["CCI-000366"]
  tag nist: ["CM-6 b", "Rev_4"]

  describe.one do
    describe file("/boot/grub/grub.conf") do
      it { should exist }
    end
    describe file("/boot/grub/grub.conf") do
      its("uid") { should cmp 0 }
    end
    describe file("/boot/efi/EFI/redhat/grub.conf") do
      it { should exist }
    end
    describe file("/boot/efi/EFI/redhat/grub.conf") do
      its("uid") { should cmp 0 }
    end
  end
end