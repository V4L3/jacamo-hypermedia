/* Initial beliefs and rules */

entry_url("http://localhost:8080/workspaces/10").
relevant_workspace("103").
relevant_artifact("w1"). // name of the relevant artifact this could also happen based on affordances of discovered artifacts
heating("On").


/* Initial goals */

!start.

+!start : entry_url(Url) & relevant_workspace(X) <-
  .print("hello world. I am the T-Agent situated in building ", X);
  makeArtifact("notification-server", "yggdrasil.NotificationServerArtifact", ["localhost", 8083], _);
  start;
  !load_environment("10", Url);
  .print("Environment loaded...").

+temperature(Temp) : heating(State) & Temp < 21.0 & State == "On" <-
  .print("Received temperature: ", Temp);
  .print("Heating is already on...").

+temperature(Temp) : heating(State) & Temp < 21.0 & State == "Off" <-
  .print("Received temperature: ", Temp);
  .print("Turing heating on...");
  -+heating("On").

+temperature(Temp) : heating(State) & Temp > 21.0 & State == "On" <-
  .print("Received temperature: ", Temp);
  .print("Turing heating off...");
  -+heating("Off").

+temperature(Temp) : heating(State) & Temp > 21 & State == "Off" <-
  .print("Received temperature: ", Temp);
  .print("Heating is already off...").

+temperature(Temp) : true <-
  .print("Received temperature: ", Temp).



{ include("inc/hypermedia.asl") }
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
