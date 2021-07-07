control "V-38525" do
  title "The audit system must be configured to audit all attempts to alter
system time through stime."
  desc  "Arbitrary changes to the system time can be used to obfuscate
nefarious activities in log files, as well as to confuse network services that
are highly dependent upon an accurate system time (such as sshd). All changes
to the system time should be audited."
  impact 'low'
  tag "gtitle": "SRG-OS-000062"
  tag "gid": "V-38525"
  tag "rid": "SV-50326r4_rule"
  tag "stig_id": "RHEL-06-000169"
  tag "fix_id": "F-43473r4_fix"
  tag "cci": ["CCI-000169"]
  tag "nist": ["AU-12 a", "Rev_4"]
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
  desc 'check', "If the system is 64-bit only, this is not applicable.

To determine if the system is configured to audit calls to the \"stime\" system
call, run the following command:

$ sudo grep -w \"stime\" /etc/audit/audit.rules

If the system is configured to audit this activity, it will return a line.

If the system is not configured to audit time changes, this is a finding. "
  desc 'fix', "On a 32-bit system, add the following to
\"/etc/audit/audit.rules\":

# audit_time_rules
-a always,exit -F arch=b32 -S stime -k audit_time_rules

On a 64-bit system, the \"-S stime\" is not necessary. The -k option allows for
the specification of a key in string form that can be used for better reporting
capability through ausearch and aureport. Multiple system calls can be defined
on the same line to save space if desired, but is not required. See an example
of multiple combined syscalls:

-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k
audit_time_rules"

  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^-[Aa][\s]*(?:exit,always|always,exit)[\s]+-F[\s]+arch=b32.*(?:-S[\s]+|,)stime(?:[\s]+|,).*-k[\s]+[\S]+[\s]*$/) }
  end
end

