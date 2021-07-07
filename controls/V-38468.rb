control "V-38468" do
  title "The audit system must take appropriate action when the audit storage
volume is full."
  desc  "Taking appropriate action in case of a filled audit storage volume
will minimize the possibility of losing audit records."
  impact 'medium'
  tag "gtitle": "SRG-OS-000047"
  tag "gid": "V-38468"
  tag "rid": "SV-50268r1_rule"
  tag "stig_id": "RHEL-06-000510"
  tag "fix_id": "F-43413r1_fix"
  tag "cci": ["CCI-000140"]
  tag "nist": ["AU-5 b", "Rev_4"]
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
  desc 'check', "Inspect \"/etc/audit/auditd.conf\" and locate the following
line to determine if the system is configured to take appropriate action when
the audit storage volume is full:

# grep disk_full_action /etc/audit/auditd.conf
disk_full_action = [ACTION]


If the system is configured to \"suspend\" when the volume is full or
\"ignore\" that it is full, this is a finding."
  desc 'fix', "The \"auditd\" service can be configured to take an action when
disk space starts to run low. Edit the file \"/etc/audit/auditd.conf\". Modify
the following line, substituting [ACTION] appropriately:

disk_full_action = [ACTION]

Possible values for [ACTION] are described in the \"auditd.conf\" man page.
These include:

\"ignore\"
\"syslog\"
\"exec\"
\"suspend\"
\"single\"
\"halt\"


Set this to \"syslog\", \"exec\", \"single\", or \"halt\"."

  describe parse_config_file('/etc/audit/auditd.conf') do
    its('disk_full_action') { should_not be_nil }
    its('disk_full_action.downcase') { should_not be_in ['suspend', 'ignore'] }
  end
end

