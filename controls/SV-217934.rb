# encoding: UTF-8

control "SV-217934" do
  title "The Datagram Congestion Control Protocol (DCCP) must be disabled unless required."
  desc "Disabling DCCP protects the system against exploitation of any flaws in its implementation."
  desc "default", "Disabling DCCP protects the system against exploitation of any flaws
in its implementation."
  desc "check", "If the system is configured to prevent the loading of the \"dccp\" kernel module, it will contain lines inside any file in \"/etc/modprobe.d\" or the deprecated\"/etc/modprobe.conf\". These lines instruct the module loading system to run another program (such as \"/bin/true\") upon a module \"install\" event. Run the following command to search for such lines in all files in \"/etc/modprobe.d\" and the deprecated \"/etc/modprobe.conf\": 

$ grep -r dccp /etc/modprobe.conf /etc/modprobe.d | grep -i “/bin/true”| grep -v “#”

If no line is returned, this is a finding."
  desc "fix", "The Datagram Congestion Control Protocol (DCCP) is a relatively new transport layer protocol, designed to support streaming media and telephony. To configure the system to prevent the \"dccp\" kernel module from being loaded, add the following line to a file in the directory \"/etc/modprobe.d\": 

install dccp /bin/true"
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000096"
  tag gid: "V-217934"
  tag rid: "SV-217934r603264_rule"
  tag stig_id: "RHEL-06-000124"
  tag fix_id: "F-19413r462395_fix"
  tag cci: ["CCI-000382"]
  tag nist: ["CM-7 b", "Rev_4"]

  describe kernel_module('dccp') do
    it { should_not be_loaded }
    it { shold_not be_enabled }
    it { should be_blacklisted }
  end
end