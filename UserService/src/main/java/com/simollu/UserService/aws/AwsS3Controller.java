package com.simollu.UserService.aws;

import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/s3")
public class AwsS3Controller {

  private final AwsS3Service awsS3service;

  @PostMapping("/upload")
  public FileDto upload(@RequestParam(value = "file") MultipartFile multipartFile)
      throws IOException {
    return awsS3service.upload(multipartFile, "compressed");
  }

  @PostMapping("/uploadProblem")
  public FileDto uploadProblem(@RequestParam(value = "file") MultipartFile multipartFile)
      throws IOException {
    return awsS3service.upload(multipartFile, "problem");
  }

  @GetMapping("/getImageUrl")
  public String getImageUrl(@RequestParam(value = "filename") String path)
      throws IOException {
    return awsS3service.getFilePath(path);
  }

  //this is upload image and making temporary link to access image
  @PostMapping("/getPresignedUrl")
  public FileDto getPresignedUrl(@RequestParam(value = "file") MultipartFile multipartFile)
      throws IOException {
    return awsS3service.uploadToPresignUrl(multipartFile, "sccs");
  }

  //get temporary presignedurl from filename
  @GetMapping("/temporaryUrl")
  public String getTemporaryUrl(@RequestParam(value = "filename")  String filename)
      throws IOException {
    return awsS3service.getTemporaryUrl(filename);
  }

}
