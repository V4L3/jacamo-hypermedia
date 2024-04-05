import org.gradle.kotlin.dsl.*

plugins {
    java
    eclipse
}

defaultTasks("run")

version = "1.0"
group = "org.jacamo"

repositories {
    mavenCentral()
    maven(url = "https://raw.github.com/jacamo-lang/mvn-repo/master")
    maven(url = "https://repo.gradle.org/gradle/libs-releases")
    maven(url = "https://jitpack.io")
    // maven(url = "https://jade.tilab.com/maven/")
    flatDir {
        dirs("lib")
    }
}

dependencies {
    implementation("org.jacamo:jacamo:0.9-SNAPSHOT")
    implementation("com.github.interactions-hsg:wot-td-java:v0.1.2")
    implementation("org.eclipse.rdf4j:rdf4j-runtime:3.2.1")
    implementation("org.apache.httpcomponents.client5:httpclient5:5.0")
    implementation("org.apache.httpcomponents.client5:httpclient5-fluent:5.0")
    implementation("org.eclipse.jetty.aggregate:jetty-all:9.0.0.RC2")
    implementation("com.google.code.gson:gson:2.8.6")
    implementation("junit:junit:4.13")
}

sourceSets {
    main {
        java {
            srcDirs("src/env", "src/agt", "src/org", "src/test/java")
        }
        resources {
            srcDir("src/resources")
        }
    }
}

val run by tasks.creating(JavaExec::class) {
    group = "JaCaMo"
    description = "Runs the JaCaMo application"
    doFirst {
        mkdir("log")
    }
    mainClass.set("jacamo.infra.JaCaMoLauncher")
    if (project.hasProperty("jcmFile")) {
        args(project.property("jcmFile"))
    } else {
        args("jacamo_hypermedia.jcm")
    }
    classpath = sourceSets["main"].runtimeClasspath
}

val runCounter by tasks.creating(JavaExec::class) {
    group = "JaCaMo"
    description = "Runs the CounterAgent"
    doFirst {
        mkdir("log")
    }
    mainClass.set("jacamo.infra.JaCaMoLauncher")
    args("jacamo_hypermedia_counter.jcm")
    classpath = sourceSets["main"].runtimeClasspath
}

val runBlindsAgent by tasks.creating(JavaExec::class) {
    group = "JaCaMo"
    description = "Runs the BlindsAgent"
    doFirst {
        mkdir("log")
    }
    mainClass.set("jacamo.infra.JaCaMoLauncher")
    args("jacamo_hypermedia_BA.jcm")
    classpath = sourceSets["main"].runtimeClasspath
}

val runTAgent by tasks.creating(JavaExec::class) {
    group = "JaCaMo"
    description = "Runs the T Agent in building A"
    doFirst {
        mkdir("log")
    }
    mainClass.set("jacamo.infra.JaCaMoLauncher")
    args("jacamo_hypermedia_TA.jcm")
    classpath = sourceSets["main"].runtimeClasspath
}

val runSetupAgent by tasks.creating(JavaExec::class) {
    group = "JaCaMo"
    description = "Runs the Setup Agent (creates shared artifacts)"
    doFirst {
        mkdir("log")
    }
    mainClass.set("jacamo.infra.JaCaMoLauncher")
    args("jacamo_hypermedia_setup.jcm")
    classpath = sourceSets["main"].runtimeClasspath
}

tasks.named("clean") {
    doFirst {
        delete("bin", "build", "log")
    }
}

