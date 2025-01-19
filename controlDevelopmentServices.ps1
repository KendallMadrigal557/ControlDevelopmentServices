
# Detectar el idioma del sistema 
# Detect system language
$language = "en"  
$culture = (Get-Culture).Name

if ($culture -like "es-*") {
    $language = "es"
}

# Servicios de desarrollo comunes
# Common development services
$services = @(
    "MSSQLSERVER", # SQL Server
    "SQLSERVERAGENT", # SQL Server Agent
    "SQLWriter", # SQL Server Writer
    "MySQL", # MySQL DB
    "PostgreSQL", # PostgreSQL DB
    "MongoDB", # MongoDB
    "Redis", # Redis
    "Docker", # Docker Daemon
    "docker.service", # Docker Service
    "nginx", # NGINX Web Server
    "apache2", # Apache Web Server
    "RabbitMQ", # RabbitMQ
    "Kafka", # Kafka
    "Elasticsearch", # Elasticsearch
    "Logstash", # Logstash
    "Filebeat", # Filebeat
    "Kibana", # Kibana
    "Grafana", # Grafana
    "Prometheus", # Prometheus
    "Jenkins", # Jenkins
    "GitLab-Runner", # GitLab Runner
    "Vault", # HashiCorp Vault
    "Consul" # HashiCorp Consul
)

# Mensajes en diferentes idiomas
# Messages in different languages
$messages = @{
    "es" = @{
        "firstOption"         = "¿Qué deseas hacer?"
        "stopServices"        = "Detener todos los servicios de desarrollo"
        "startServices"       = "Iniciar todos los servicios de desarrollo"
        "selectOption"        = "Selecciona una opción (1/2)"
        "stopped"             = "Servicios detenidos."
        "notInstalledEnables" = " no está instalado o no está en ejecución"
        "started"             = "Servicios iniciados."
        "notInstalled"        = " no está instalado."
        "stopping"            = "Deteniendo todos los servicios de desarrollo..."
        "starting"            = "Iniciando todos los servicios de desarrollo..."
        "completed"           = "Proceso completado."
        "optionInvalid"       = "Opción no válida. Saliendo..."
        "pressKey"            = "Presiona una tecla para continuar..."
    }
    "en" = @{
        "firstOption"         = "What do you want to do?"
        "stopServices"        = "Stop all development services"
        "startServices"       = "Start all development services"
        "selectOption"        = "Select an option (1/2)"
        "stopped"             = "Services stopped."
        "notInstalledEnables" = " is not installed or is not running."
        "started"             = "Services started"
        "notInstalled"        = " is not installed."
        "stopping"            = "Stopping all development services..."
        "starting"            = "Starting all development services..."
        "completed"           = "Process completed."
        "optionInvalid"       = "Invalid option. Exiting..."
        "pressKey"            = "Press any key to continue..."
    }
}

# Función para detener servicios
# Function to stop services
function Stop-Services {
    Write-Host $messages[$language]["stopping"]
    foreach ($service in $services) {
        $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue
        if ($serviceStatus) {
            Stop-Service -Name $service -Force
            Write-Host $service  $messages[$language]["stopped"]
        }
        else {
            Write-Host $service  $messages[$language]["notInstalledEnables"]
        }
    }
    Write-Host $messages[$language]["completed"]
}

# Función para iniciar servicios
# Function to start services
function Start-Services {
    Write-Host $messages[$language]["starting"]
    foreach ($service in $services) {
        $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue
        if ($serviceStatus) {
            Start-Service -Name $service
            Write-Host $service $messages[$language]["started"]
        }
        else {
            Write-Host $service $messages[$language]["notInstalled"]
        }
    }
    Write-Host $messages[$language]["completed"]
}

# Función para esperar una tecla
# Function to wait for a key
function Wait-ForKeyPress {
    Write-Host -NoNewLine  $messages[$language]["completed"]
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

# Menú interactivo
# Interactive menu
Write-Host $messages[$language]["firstOption"]
Write-Host $messages[$language]["stopServices"] " (1)"
Write-Host $messages[$language]["startServices"] " (2)"
$option = Read-Host $messages[$language]["selectOption"]

switch ($option) {
    1 {
        Stop-Services
        Wait-ForKeyPress
    }
    2 {
        Start-Services
        Wait-ForKeyPress
    }
    default {
        Write-Host $messages[$language]["optionInvalid"]
        Wait-ForKeyPress
    }
}