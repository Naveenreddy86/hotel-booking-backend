# Use OpenJDK 21 as the base image for building the project
FROM openjdk:21 AS build

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY . .

# Run the Maven build to package the application
RUN mvn clean install -DskipTests

# Use OpenJDK 21 as the runtime image
FROM openjdk:21-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled jar from the build image
COPY --from=build /app/target/hotel-booking-backend.jar /app/hotel-booking-backend.jar

# Expose the port your app will run on
EXPOSE 4040

# Run the Java application
CMD ["java", "-jar", "hotel-booking-backend.jar"]
