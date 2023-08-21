<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $ssid = $_POST['ssid'];
    $password = $_POST['password'];

    // Validate input
    if (empty($ssid) || empty($password)) {
        echo "SSID and password are required.";
    } else {
        // Generate the content for the wpa_supplicant.conf file
        $content = "network={\n";
        $content .= "\tssid=\"$ssid\"\n";
        $content .= "\tpsk=\"$password\"\n";
        $content .= "}\n";

        // Append the content to the wpa_supplicant.conf file
        $file_path = "/etc/wpa_supplicant/wpa_supplicant.conf";
        if (file_put_contents($file_path, $content, FILE_APPEND)) {
            echo "WiFi details added successfully.";

            // Restart the network interface to apply the changes
            shell_exec('sudo systemctl restart networking');
        } else {
            echo "Error: Could not write to file.";
        }
    }
}
?>
