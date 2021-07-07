control "V-38603" do
  title "The ypserv package must not be installed."
  desc  "Removing the \"ypserv\" package decreases the risk of the accidental
(or intentional) activation of NIS or NIS+ services."
  impact 'medium'
  tag "gtitle": "SRG-OS-000095"
  tag "gid": "V-38603"
  tag "rid": "SV-50404r1_rule"
  tag "stig_id": "RHEL-06-000220"
  tag "fix_id": "F-43551r1_fix"
  tag "cci": ["CCI-000381"]
  tag "nist": ["CM-7 a", "Rev_4"]
  tag "false_negatives": nil
  tag "false_positives": nil
  tag "documentable": false
  tag "mitigations": nil
  tag "severity_override_guidance": false
  tag "potential_impacts": nil
  tag "third_party_tools": nil
  tag "mitigation_controls": nil
  tag "responsibility": nil
  tag "ia_controls": nil
  desc 'check', "Run the following command to determine if the \"ypserv\"
package is installed:

# rpm -q ypserv


If the package is installed, this is a finding."
  desc 'fix', "The \"ypserv\" package can be uninstalled with the following
command:

# yum erase ypserv"

  describe package("ypserv") do
    it { should_not be_installed }
  end
end

