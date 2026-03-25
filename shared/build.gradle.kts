import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
    id("maven-publish")
}

group = project.properties["GROUP_ID"]?.toString() ?: "id.tiooooo"
version = project.properties["VERSION_NAME"]?.toString() ?: "0.0.1"

kotlin {
    val xcframework = XCFramework()

    androidTarget {
        compilerOptions {
            jvmTarget.set(JvmTarget.JVM_11)
        }
    }
    
    listOf(
        iosArm64(),
        iosSimulatorArm64()
    ).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "Shared"
            isStatic = true
            xcframework.add(this)
        }
    }
    
    sourceSets {
        commonMain.dependencies {
            // put your Multiplatform dependencies here
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
    }
}

android {
    namespace = "org.example.project.shared"
    compileSdk = libs.versions.android.compileSdk.get().toInt()
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    defaultConfig {
        minSdk = libs.versions.android.minSdk.get().toInt()
    }
}

publishing {
    repositories {
        maven {
            name = "GitHubPackages"
            url = uri(
                "https://maven.pkg.github.com/${System.getenv("REPOSITORY") ?: project.properties["GITHUB_REPOSITORY_FALLBACK"]}"
            )
            credentials {
                username = System.getenv("ACTOR")
                password = System.getenv("TOKEN")
            }
        }
    }
}

// ---------------------------------------------------------------------------
// XCFramework packaging tasks
// ---------------------------------------------------------------------------

val xcframeworkName = "shared"
val xcframeworkOutputDir = layout.buildDirectory.dir("XCFrameworks/release")

/**
 * Zips the assembled XCFramework so it can be attached to a GitHub Release
 * and referenced by the Swift Package Manager binary target.
 *
 * Run after: ./gradlew :shared:assembleSharedReleaseXCFramework
 */
val zipXCFramework by tasks.registering(Zip::class) {
    dependsOn("assembleSharedReleaseXCFramework")
    from(xcframeworkOutputDir)
    include("$xcframeworkName.xcframework/**")
    archiveFileName.set("$xcframeworkName.xcframework.zip")
    destinationDirectory.set(layout.buildDirectory.dir("distributions"))
}

