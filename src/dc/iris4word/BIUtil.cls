Class dc.iris4word.BIUtil Extends %RegisteredObject
{

/// Get word report about an interoperability production
ClassMethod GetBIDocReport(wordDocumentPath As %String) As %Status
{
    
    Set response = ..GetDeepSeeAssets()

    Set templatePath = $SYSTEM.Util.InstallDirectory()_"bitemplate.docx"
    Set sc = ##class(dc.iris4word.WordUtil).GenerateWordFileFromJSON(response.%ToJSON(), templatePath, wordDocumentPath)
    
    Return sc
}

ClassMethod GetDeepSeeAssets() As %DynamicObject
{
    Set result = {}

    Set cubes = {}.%FromJSON(..GetCubesData())
    Set dashboards = {}.%FromJSON(..GetDashboardsData())
    Set pivots = {}.%FromJSON(..GetPivotsData())

    Set result.cubes = cubes.Result.Cubes
    Set result.dashboards = dashboards.Result.Dashboards
    Set result.pivots = pivots.Result.Pivots
    
    return result
}

ClassMethod GetCubesData() As %String [ Language = python ]
{
    import urllib.request
    import base64
    url = "http://localhost:52773/api/deepsee/v3/user/Info/Cubes"
    username = "_SYSTEM"
    password = "SYS"

    # Encode credentials for basic authentication
    credentials = f"{username}:{password}"
    encoded_credentials = base64.b64encode(credentials.encode()).decode()

    # Create a request object with the Authorization header
    request = urllib.request.Request(url)
    request.add_header("Authorization", f"Basic {encoded_credentials}")

    try:
        with urllib.request.urlopen(request) as response:
            # Read the response and decode it to a string
            response_string = response.read().decode('utf-8')
            return response_string
    except urllib.error.URLError as e:
        return f"Error accessing the API: {e.reason}"
    except Exception as e:
        return f"An unexpected error occurred: {e}"
}

ClassMethod GetDashboardsData() As %String [ Language = python ]
{
    import urllib.request
    import base64
    url = "http://localhost:52773/api/deepsee/v3/user/Info/Dashboards"
    username = "_SYSTEM"
    password = "SYS"

    # Encode credentials for basic authentication
    credentials = f"{username}:{password}"
    encoded_credentials = base64.b64encode(credentials.encode()).decode()

    # Create a request object with the Authorization header
    request = urllib.request.Request(url)
    request.add_header("Authorization", f"Basic {encoded_credentials}")

    try:
        with urllib.request.urlopen(request) as response:
            # Read the response and decode it to a string
            response_string = response.read().decode('utf-8')
            return response_string
    except urllib.error.URLError as e:
        return f"Error accessing the API: {e.reason}"
    except Exception as e:
        return f"An unexpected error occurred: {e}"
}

ClassMethod GetPivotsData() As %String [ Language = python ]
{
    import urllib.request
    import base64
    url = "http://localhost:52773/api/deepsee/v3/user/Info/Pivots"
    username = "_SYSTEM"
    password = "SYS"

    # Encode credentials for basic authentication
    credentials = f"{username}:{password}"
    encoded_credentials = base64.b64encode(credentials.encode()).decode()

    # Create a request object with the Authorization header
    request = urllib.request.Request(url)
    request.add_header("Authorization", f"Basic {encoded_credentials}")

    try:
        with urllib.request.urlopen(request) as response:
            # Read the response and decode it to a string
            response_string = response.read().decode('utf-8')
            return response_string
    except urllib.error.URLError as e:
        return f"Error accessing the API: {e.reason}"
    except Exception as e:
        return f"An unexpected error occurred: {e}"
}

}
