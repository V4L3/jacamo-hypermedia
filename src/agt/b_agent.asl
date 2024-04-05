/* Initial beliefs and rules */

entry_url("http://localhost:8080/workspaces/10").
desired_light_level(0.5).


/* Initial goals */

!start.

/* Plans */

+!start : entry_url(Url) & desired_light_level(Level) <-
  .print("hello world. I am the BlindsAgent. My Goal is to keep the light level at ", Level);
  makeArtifact("notification-server", "yggdrasil.NotificationServerArtifact", ["localhost", 8083], _);
  start;
  !load_environment("10", Url);
  .print("Environment loaded...");
  !create_blind.


+!create_blind : true <-
  .print("creating blind");
  invokeAction("makeArtifact",
    ["artifactClass", "artifactName"],
    ["http://example.org/Blind", "b1"])[artifact_name("101")];
    .print("blind created").


{ include("inc/hypermedia.asl") }
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
