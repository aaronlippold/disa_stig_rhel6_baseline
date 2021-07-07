control "V-38693" do
  title "The system must require passwords to contain no more than three
consecutive repeating characters."
  desc  "Passwords with excessive repeating characters may be more vulnerable
to password-guessing attacks."
  impact 'low'
  tag "gtitle": "SRG-OS-999999"
  tag "gid": "V-38693"
  tag "rid": "SV-50494r3_rule"
  tag "stig_id": "RHEL-06-000299"
  tag "fix_id": "F-43642r3_fix"
  tag "cci": ["CCI-000366"]
  tag "nist": ["CM-6 b", "Rev_4"]
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
  desc 'check', "To check the maximum value for consecutive repeating
characters, run the following command:

$ grep pam_cracklib /etc/pam.d/system-auth /etc/pam.d/password-auth

Look for the value of the \"maxrepeat\" parameter.

If \"maxrepeat\" is not found or is set to a value less than \"3\", this is a
finding."
  desc 'fix', "The pam_cracklib module's \"maxrepeat\" parameter controls
requirements for consecutive repeating characters. When set to a positive
number, it will reject passwords which contain more than that number of
consecutive characters.

Edit /etc/pam.d/system-auth and /etc/pam.d/password-auth adding \"maxrepeat=3\"
after pam_cracklib.so to prevent a run of (3 + 1) or more identical characters.

password required pam_cracklib.so maxrepeat=3 "

  pam_files = ["/etc/pam.d/system-auth", "/etc/pam.d/password-auth"]
  pam_files.each do |pam_file|
    lines = command("grep pam_cracklib #{pam_file}").stdout.strip.split("\n")
    describe "pam_cracklib lines in #{pam_file}" do
      subject { lines }
      it { should_not be_empty }
    end

    lines.each do |l|
      describe l do
        it { should match %r{\bmaxrepeat=([3-9]|[1-9][0-9]+)\b} }
      end
    end
  end
end

