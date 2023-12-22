import subprocess
import redis
import art

if __name__ == "__main__":
    r = redis.Redis(host = "localhost", port = 6379, decode_responses = True)
    r.set("message", "Taiwan is awesome! Visit Taiwan!\nRemember to vote in 2024!")

    border = "=============================================================================================================================================="
    
    project_logo = art.text2art("LWTaiwanCurrencyConverter", font = "small")

    # Print upper border using the echo command
    subprocess.run(["echo", border])
    
    print(project_logo, end = "")
    print(r.get("message"))
    
    lower_border = subprocess.check_output(["echo", border])
    print(lower_border.decode("utf-8"), end = "")  # Decode the bytes
