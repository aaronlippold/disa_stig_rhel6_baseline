control "V-38582" do
  title "The xinetd service must be disabled if no network services utilizing
it are enabled."
  desc  "The xinetd service provides a dedicated listener service for some
programs, which is no longer necessary for commonly-used network services.
Disabling it ensures that these uncommon services are not running, and also
prevents attacks against xinetd itself."
  impact 'medium'
  tag "gtitle": "SRG-OS-000096"
  tag "gid": "V-38582"
  tag "rid": "SV-50383r2_rule"
  tag "stig_id": "RHEL-06-000203"
  tag "fix_id": "F-43530r2_fix"
  tag "cci": ["CCI-000382"]
  tag "nist": ["CM-7 b", "Rev_4"]
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
  desc 'check', "If network services are using the xinetd service, this is not
applicable.

To check that the \"xinetd\" service is disabled in system boot configuration,
run the following command:

# chkconfig \"xinetd\" --list

Output should indicate the \"xinetd\" service has either not been installed, or
has been disabled at all runlevels, as shown in the example below:

# chkconfig \"xinetd\" --list
\"xinetd\" 0:off 1:off 2:off 3:off 4:off 5:off 6:off

Run the following command to verify \"xinetd\" is disabled through current
runtime configuration:

# service xinetd status

If the service is disabled the command will return the following output:

xinetd is stopped


If the service is running, this is a finding."
  desc 'fix', "The \"xinetd\" service can be disabled with the following
commands:

# chkconfig xinetd off
# service xinetd stop"

  describe.one do
    describe package("xinetd") do
      it { should_not be_installed }
    end
    describe service("xinetd") do
      its("runlevels(?-mix:0)") { should be_enabled }
      its("runlevels(?-mix:1)") { should be_enabled }
      its("runlevels(?-mix:2)") { should be_enabled }
      its("runlevels(?-mix:3)") { should be_enabled }
      its("runlevels(?-mix:4)") { should be_enabled }
      its("runlevels(?-mix:5)") { should be_enabled }
      its("runlevels(?-mix:6)") { should be_enabled }
    end
  end
end

