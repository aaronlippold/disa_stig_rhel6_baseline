control "V-38558" do
  title "The audit system must be configured to audit all discretionary access
control permission modifications using lchown."
  desc  "The changing of file permissions could indicate that a user is
attempting to gain access to information that would otherwise be disallowed.
Auditing DAC modifications can facilitate the identification of patterns of
abuse among both authorized and unauthorized users."
  impact 'low'
  tag "gtitle": "SRG-OS-000064"
  tag "gid": "V-38558"
  tag "rid": "SV-50359r3_rule"
  tag "stig_id": "RHEL-06-000192"
  tag "fix_id": "F-43506r2_fix"
  tag "cci": ["CCI-000172"]
  tag "nist": ["AU-12 c", "Rev_4"]
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
  desc 'check', "To determine if the system is configured to audit calls to the
\"lchown\" system call, run the following command:

$ sudo grep -w \"lchown\" /etc/audit/audit.rules

If the system is configured to audit this activity, it will return several
lines.

If no line is returned, this is a finding. "
  desc 'fix', "At a minimum, the audit system should collect file permission
changes for all users and root. Add the following to
\"/etc/audit/audit.rules\":

-a always,exit -F arch=b32 -S lchown -F auid>=500 -F auid!=4294967295 \\
-k perm_mod
-a always,exit -F arch=b32 -S lchown -F auid=0 -k perm_mod

If the system is 64-bit, then also add the following:

-a always,exit -F arch=b64 -S lchown -F auid>=500 -F auid!=4294967295 \\
-k perm_mod
-a always,exit -F arch=b64 -S lchown -F auid=0 -k perm_mod"

  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^[\s]*-a[\s](?:always,exit|exit,always)+(?:.*-F[\s]+arch=b32[\s]+)(?:.*(?:,|-S[\s]+)lchown(?:,|[\s]+))(?:.*-F\s+auid>=500[\s]+)(?:.*-F\s+auid!=(?:-1|4294967295)[\s]+).*-k[\s]+[\S]+[\s]*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^[\s]*-a[\s](?:always,exit|exit,always)+(?:.*-F[\s]+arch=b32[\s]+)(?:.*(?:,|-S[\s]+)lchown(?:,|[\s]+))(?:.*-F\s+auid=0[\s]+).*-k[\s]+[\S]+[\s]*$/) }
  end
  describe.one do
    
  end
end

