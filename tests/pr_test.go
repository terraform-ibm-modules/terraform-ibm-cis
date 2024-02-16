package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const defaultExampleTerraformDir = "examples/complete"
const fscloudExampleTerraformDir = "examples/fscloud"
const resourceGroup = "geretain-test-resources"
const domainName = "prtest.goldeneye.dev.cloud.ibm.com"

func setupOptions(t *testing.T, prefix string, domain_name string, dir string) *testhelper.TestOptions {
	options := testhelper.TestOptionsDefaultWithVars(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  dir,
		Prefix:        prefix,
		ResourceGroup: resourceGroup,
	})

	options.TerraformVars = map[string]interface{}{
		"prefix":      options.Prefix,
		"domain_name": domain_name,
	}

	return options
}

func TestRunCompleteExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "cis-new", domainName, defaultExampleTerraformDir)

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeCompleteExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "cis-new-upg", domainName, defaultExampleTerraformDir)

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}

func TestRunFsCloudExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "cis-fs", domainName, fscloudExampleTerraformDir)

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}
