package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const defaultExampleTerraformDir = "examples/complete"
const resourceGroup = "geretain-test-resources"

func setupOptions(t *testing.T, prefix string, plan string, domain_name string) *testhelper.TestOptions {
	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  defaultExampleTerraformDir,
		Prefix:        prefix,
		ResourceGroup: resourceGroup,
	})

	options.TerraformVars = map[string]interface{}{
		"prefix":      options.Prefix,
		"plan":        plan,
		"domain_name": domain_name,
	}

	return options
}

func TestRunCompleteExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "cis-new", "standard-next", "prtest.goldeneye.dev.cloud.ibm.com")

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeCompleteExample(t *testing.T) {
	t.Parallel()
	t.Skip()
	options := setupOptions(t, "cis-new-upg", "standard-next", "prtest.goldeneye.dev.cloud.ibm.com")

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
