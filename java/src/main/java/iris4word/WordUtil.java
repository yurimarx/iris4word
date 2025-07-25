package iris4word;

import com.deepoove.poi.XWPFTemplate;
import com.deepoove.poi.config.Configure;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;
import java.util.Map;

public class WordUtil {

    public void createFromFile(String jsonFileName, String wordTemplateFileName, String wordFileName) {
        
    	java.util.logging.Logger julLogger2 = java.util.logging.Logger.getLogger("com.deepoove.poi.render.processor.LogProcessor");
    	julLogger2.setLevel(java.util.logging.Level.OFF);
    	
    	java.util.logging.Logger julLogger = java.util.logging.Logger.getLogger("org.slf4j.Logger");
        julLogger.setLevel(java.util.logging.Level.OFF);
        
    	ObjectMapper objectMapper = new ObjectMapper(); 
    	XWPFTemplate template = null;
    	
        try {
            File jsonFile = new File(jsonFileName);
            
            @SuppressWarnings("unchecked")
			Map<String, Object> data = objectMapper.readValue(jsonFile, Map.class);

            Configure config = Configure.builder().build();

            template = XWPFTemplate.compile(wordTemplateFileName, config).render(data);

            template.writeToFile(wordFileName);
            

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	if(template != null) {        		
        		try {
					template.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
        	}
		}
    }
	
}
