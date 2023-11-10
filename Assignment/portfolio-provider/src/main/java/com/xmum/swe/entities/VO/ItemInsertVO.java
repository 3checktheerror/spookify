package com.xmum.swe.entities.VO;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.NotBlank;
import java.sql.Blob;
import java.util.Map;

@Data
@ApiModel("Params for item insertion")
public class ItemInsertVO {

    @ApiModelProperty("item group")
    @JsonProperty("igroupId")
    private String igroupId;

    @JsonProperty("name")
    private String name;

    @JsonProperty("gender")
    private String gender;

    @JsonProperty("email")
    private String email;

    @JsonProperty("file")
    private MultipartFile file;

    @JsonProperty("md5")
    private String md5;

    @ApiModelProperty("additional params")
    @JsonProperty("map")
    private Map<String, Object> map;

    @JsonProperty("token")
    private String token;

    @JsonProperty("sessionId")
    private String sessionId;

    @ApiModelProperty("visitor id(for this item)")
    @JsonProperty("vIdFk")
    private String vIdFk;
}
