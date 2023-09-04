# Import necessary libraries
from dotenv import load_dotenv
import os
import json
import time
from azure.cognitiveservices.vision.computervision import ComputerVisionClient
from azure.cognitiveservices.vision.computervision.models import OperationStatusCodes
from msrest.authentication import CognitiveServicesCredentials

# Global variables
folder_path = "images"

# Define function for reading text from an image
def GetTextfromImage(client, image_file):
    # Use Read API to extract text from image
    extracted_text = []
    
    with open(image_file, mode="rb") as image_data:
        read_op = client.read_in_stream(image_data, raw=True)

        # Get the async operation ID to monitor results
        operation_location = read_op.headers["Operation-Location"]
        operation_id = operation_location.split("/")[-1]

        # Wait for the asynchronous operation to complete
        while True:
            read_results = client.get_read_result(operation_id)
            if read_results.status not in [OperationStatusCodes.running, OperationStatusCodes.not_started]:
                break
            time.sleep(1)

        # If the operation succeeded, process the extracted text line by line
        if read_results.status == OperationStatusCodes.succeeded:
            for page in read_results.analyze_result.read_results:
                for line in page.lines:
                    extracted_text.append(line.text)
                    
    return extracted_text

# Read files in a specified folder
def process_folder(folder_path):
    file_list = []
    
    if os.path.exists(folder_path) and os.path.isdir(folder_path):
        for filename in os.listdir(folder_path):
            if filename != ".DS_Store":
                file_list.append(filename)
    else:
        print("Invalid path:", folder_path)

    return file_list

# Main function
def main():
    # Load configuration settings from .env file
    load_dotenv()
    cog_endpoint = os.getenv("COG_SERVICE_ENDPOINT")
    cog_key = os.getenv("COG_SERVICE_KEY")
        
    # Initialize Cognitive Services client
    credential = CognitiveServicesCredentials(cog_key)
    cv_client = ComputerVisionClient(cog_endpoint, credential)

    # Process images in the folder
    file_names = process_folder(folder_path)
    
    text_data = {}  # Dictionary to store text data
    
    for item in file_names:
        image_file = os.path.join(folder_path, item)
        text_list = GetTextfromImage(cv_client, image_file)
        text_data[item] = text_list
        
    # Write text data to a JSON file
    with open("wine-extraction.json", "w", encoding="utf-8") as json_file:
        json.dump(text_data, json_file, ensure_ascii=False, indent=4)
    
    
    # load json file and print to screen to check
    with open("wine-extraction.json", "r", encoding="utf-8") as json_file:
        loaded_data = json.load(json_file)
    print(loaded_data)

# Ensure main is only executed when the script is run directly, not as a module
if __name__ == '__main__':
    main()

