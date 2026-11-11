
FROM maven:3.9.9-eclipse-temurin-17

WORKDIR /app

# Install Google Chrome
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    && mkdir -p /usr/share/keyrings \
    && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
       | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
       > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
COPY . .

# Chrome configuration
ENV CHROME_BIN=/usr/bin/google-chrome

# Execute Selenium TestNG tests
CMD ["mvn", "clean", "test"]
