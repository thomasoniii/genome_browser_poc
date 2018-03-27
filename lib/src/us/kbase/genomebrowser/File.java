
package us.kbase.genomebrowser;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: File</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "path",
    "shock_id",
    "ftp_url"
})
public class File {

    @JsonProperty("path")
    private String path;
    @JsonProperty("shock_id")
    private String shockId;
    @JsonProperty("ftp_url")
    private String ftpUrl;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("path")
    public String getPath() {
        return path;
    }

    @JsonProperty("path")
    public void setPath(String path) {
        this.path = path;
    }

    public File withPath(String path) {
        this.path = path;
        return this;
    }

    @JsonProperty("shock_id")
    public String getShockId() {
        return shockId;
    }

    @JsonProperty("shock_id")
    public void setShockId(String shockId) {
        this.shockId = shockId;
    }

    public File withShockId(String shockId) {
        this.shockId = shockId;
        return this;
    }

    @JsonProperty("ftp_url")
    public String getFtpUrl() {
        return ftpUrl;
    }

    @JsonProperty("ftp_url")
    public void setFtpUrl(String ftpUrl) {
        this.ftpUrl = ftpUrl;
    }

    public File withFtpUrl(String ftpUrl) {
        this.ftpUrl = ftpUrl;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((((((("File"+" [path=")+ path)+", shockId=")+ shockId)+", ftpUrl=")+ ftpUrl)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
