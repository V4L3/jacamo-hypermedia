/* Initial beliefs and rules */

entry_url("http://localhost:8080/workspaces/10").
relevant_artifact("103").
relevant_artifact("r1"). // name of the relevant artifact this could also happen based on affordances of discovered artifacts
relevant_artifact("o1"). // name of the relevant artifact this could also happen based on affordances of discovered artifacts
relevant_artifact("r2"). // name of the relevant artifact this could also happen based on affordances of discovered artifacts
relevant_artifact("o2"). // name of the relevant artifact this could also happen based on affordances of discovered artifacts
relevant_artifact("r3"). // name of the relevant artifact this could also happen based on affordances of discovered artifacts
relevant_artifact("o3"). // name of the relevant artifact this could also happen based on affordances of discovered artifacts

//Annotations
// Use Annotations to specify the Timestamp
// Fork CArtAgO and extend ObsPropertyClass to include the timestamp
// on yggdrasil and jacamoHypermedia


/* Initial goals */
!start.

+!start : entry_url(Url) <-
  .print("hello world. I am the S-Agent");
  makeArtifact("notification-server", "yggdrasil.NotificationServerArtifact", ["localhost", 8083], _);
  start;
  !load_environment("10", Url);
  .print("Environment loaded...").

+fallDetected("true")[artifact_name(_, ArtName)] : fallDetectionIsActive("true") <-
    -fallDetected("true")[artifact_name(_, ArtName)];
    .print("Fall detected...");
    .print("Notifying according authorities...").
    
+fallDetected("true")[artifact_name(_, ArtName)] : fallDetectionIsActive("false") <-
    -fallDetected("true")[artifact_name(_, ArtName)];
    .print("Fall detected...");
    .print("Room is marked empty must be a false positive").

+isLocked("true")[artifact_name(_, ArtName)] : true <-
    -isLocked("false")[artifact_name(_, ArtName)];
    .print("The room ", ArtName, " is LOCKED: ");
    -+fallDetectionIsActive("false");
    .print("Fall detection for room ", ArtName ," is now INACTIVE").

+isLocked("false")[artifact_name(_, ArtName)] : true <-
    -isLocked("true")[artifact_name(_, ArtName)];
    .print("The Room ", ArtName, " is UNLOCKED: ");
    -+fallDetectionIsActive("true");
    .print("Fall detection for room ", ArtName ," is now ACTIVE").



{ include("inc/hypermedia.asl") }
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

