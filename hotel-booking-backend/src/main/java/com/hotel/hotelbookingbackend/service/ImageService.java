package com.hotel.hotelbookingbackend.service;

import com.hotel.hotelbookingbackend.entity.Image;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ImageService {
    // Upload temporary image
    String uploadTempImage(MultipartFile file) throws IOException;

    // Move images from temp to permanent location
    List<Image> moveTempImages(Long hotelId, List<TempImageDTO> tempImages) throws IOException;

    // Delete image
    void deleteImage(Long imageId) throws IOException;

    // Get images by owner
    List<Image> getImagesByOwner(Image.OwnerType ownerType, Long ownerId);

    // Set primary image
    void setPrimaryImage(Long imageId);

    // DTO for temp image data
    class TempImageDTO {
        public String tempPath;
        public Boolean isPrimary;
        public Image.OwnerType ownerType;
        public Long ownerId;  // roomTypeId nếu ownerType = ROOM_TYPE

        public TempImageDTO(String tempPath, Boolean isPrimary, Image.OwnerType ownerType, Long ownerId) {
            this.tempPath = tempPath;
            this.isPrimary = isPrimary;
            this.ownerType = ownerType;
            this.ownerId = ownerId;
        }
    }
}