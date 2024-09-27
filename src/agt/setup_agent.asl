/* Initial beliefs and rules */

entry_url("http://localhost:8080/workspaces/10").

//Check the default, lower and upper limits of the PhantomX joint parameters: https://github.com/Interactions-HSG/leubot
sourceAngle(512). // ~180 degrees angle
targetAngle(256). // ~90 degrees angle

/* Initial goals */

!start.

/* Plans */

+!start : entry_url(Url) <-
  .print("hello world.");
  makeArtifact("notification-server", "yggdrasil.NotificationServerArtifact", ["localhost", 8081], _);
  start;
  !load_environment("10", Url);
    invokeAction("makeArtifact",
    ["artifactClass", "artifactName"],
    ["http://example.org/WeatherStation", "w2"])[artifact_name("103")];
  .wait(2000);
  !fetch_weather.
  // .wait(2000);
  // !moveBlock.

+temperature(Value) : true <-
  .print(Value, "...").

+!fetch_weather : true <-
  .print("Starting the Weather station... ");
  invokeAction("http://example.org/start",[])[artifact_name("w2")];
  .print("... success").

// +!fetch_weather : true <-
//   .print("fetching the current weather conditions");
//   invokeAction("http://example.org/getWeatherData",[])[artifact_name("w2")];
//   .print("fetching successful");
//   .wait(5000);
//   !fetch_weather.

{ include("inc/hypermedia.asl") }
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
