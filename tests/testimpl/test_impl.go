package testimpl

import (
	"testing"
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/cloudwatch"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	cloudwatchClient := GetCloudWatchClient(t)

	t.Run("TestAlarmExists", func(t *testing.T) {
		expectedAlarmName := terraform.Output(t, ctx.TerratestTerraformOptions(), "alarm_name")
		expectedAlarmArn := terraform.Output(t, ctx.TerratestTerraformOptions(), "arn")

		alarms, err := cloudwatchClient.DescribeAlarms(context.TODO(), &cloudwatch.DescribeAlarmsInput{
			AlarmNames: []string{expectedAlarmName},
		})
		assert.NoErrorf(t, err, "Unable to describe alarms, %v", err)
		assert.Equal(t, *alarms.MetricAlarms[0].AlarmArn, expectedAlarmArn, "Alarm ARN does not match")
		assert.Equal(t, *alarms.MetricAlarms[0].AlarmName, expectedAlarmName, "Alarm name does not match")
	})

	t.Run("TestAlarmMetricQueryIDs", func(t *testing.T) {
		ctx.EnabledOnlyForTests(t, "metric_query")
		expectedAlarmName := terraform.Output(t, ctx.TerratestTerraformOptions(), "alarm_name")
		expectedAlarmMetricKeys := terraform.OutputList(t, ctx.TerratestTerraformOptions(), "metric_keys")

		alarms, err := cloudwatchClient.DescribeAlarms(context.TODO(), &cloudwatch.DescribeAlarmsInput{
			AlarmNames: []string{expectedAlarmName},
		})
		assert.NoErrorf(t, err, "Unable to describe alarms, %v", err)

		metricsItems := alarms.MetricAlarms[0].Metrics
		for _, metricKey := range expectedAlarmMetricKeys {
			found := false
			for _, metricsItem := range metricsItems {
				if *metricsItem.Id == metricKey {
					found = true
					break
				}
			}
			assert.True(t, found, "Metric key %s not found", metricKey)
		}
	})
}

func GetAWSConfig(t *testing.T) (cfg aws.Config) {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	require.NoErrorf(t, err, "unable to load SDK config, %v", err)
	return cfg
}

func GetCloudWatchClient(t *testing.T) *cloudwatch.Client {
	cloudwatchClient := cloudwatch.NewFromConfig(GetAWSConfig(t))
	return cloudwatchClient
}
