# Azure Ubuntu VM as Azure DevOps Agent - One Click Deployment

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fwujysh%2Fazure-ubuntu-vsts-agent%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fwujysh%2Fazure-ubuntu-vsts-agent%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

## Before you Deploy to Azure

To register the agent to Azure DevOps, you will need to:

1. Know the Team Services URL (e.g. https://myaccount.visualstudio.com)

2. Create or obtain a Personal Access Token (PAT) from Team Services which has *"Build (read and execute)"* and *"Agent Pools (read, manage)"* priviledges/capabilities
(see https://www.visualstudio.com/en-us/docs/setup-admin/team-services/use-personal-access-tokens-to-authenticate).

3. Create or obtain a build agent pool in Team Services
(see https://www.visualstudio.com/en-us/docs/release/getting-started/configure-agents)

4. Decide on a name for your build agent (i.e. the name for your agent within the above pool).
