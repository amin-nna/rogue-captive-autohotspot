<!DOCTYPE html>
<html>
<head>
    <title>Base Station Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
        }

        .container {
            width: 90%;
            max-width: 800px;
            margin: 30px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .status-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .status-item {
            margin-bottom: 10px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        li {
            margin-bottom: 10px;
        }

        .action-button {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 12px;
            background-color: #007bff;
            color: #fff;
            border-radius: 4px;
            text-decoration: none;
        }

        .action-button:hover {
            background-color: #0056b3;
        }

        .subtitle {
            font-weight: bold;
            margin-top: 20px;
        }

        .info-item {
            margin-bottom: 10px;
        }

        .info-item span {
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Base Station Management</h2>
    <div class="status-info">
        <div class="status-item">
            <p class="info-item"><span>Base station id:</span> 005</p>
            <p class="info-item"><span>Location:</span> Pwani Basic School</p>
            <p class="info-item"><span>Current time:</span> 2023-07-25T22:12:00+01:00</p>
            <p class="info-item"><span>Current mode:</span> Hotspot | Network</p>
        </div>
        <div class="status-item">
            <p class="info-item"><span>IP address on LAN:</span> 192.168.1.52</p>
            <p class="info-item"><span>Global IP address:</span> 131.111.92.59</p>
            <p class="info-item"><span>Maintenance tunnel active:</span> Yes | No | Not available</p>
            <p class="info-item"><span>Battery charge:</span> 43%</p>
        </div>
    </div>
    <h2>Actions</h2>
    <ul>
        <li><a href="/home/ilce/logs" class="action-button">Access base station logs</a></li>
        <form action="add_wifi.php" method="post">
            <input type="text" name="ssid" placeholder="SSID">
            <input type="password" name="password" placeholder="Password">
            <input type="submit" value="Add WiFi">
        </form>
        <li><a href="#" class="action-button">Reboot the base station</a></li>
        <li><a href="#" class="action-button">(Re)start maintenance tunnel</a></li>
        <li><a href="#" class="action-button">Show status of connected sensors</a></li>
        <li><a href="#" class="action-button">Change base station location</a></li>
        <li><a href="#" class="action-button">Log an event</a></li>
    </ul>
</div>
</body>
</html>
