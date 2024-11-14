!pip install opencv-python
!pip install opencv_jupyter_ui
!pip install -q ipycanvas==0.11
from google.colab import output
output.enable_custom_widget_manager()

import cv2
from google.colab.patches import cv2_imshow
import opencv_jupyter_ui as jcv2


class EuclideanDistTracker:
    def __init__(self):
        self.center_points = {}
        self.id_count = 0
    
    def update(self, objects_rect):
        objects_bbs_ids = []
        for rect in objects_rect:
            x, y, w, h = rect
            cx = (x + x + w) // 2
            cy = (y + y + h) // 2
            same_object_detected = False
            for id, pt in self.center_points.items():
                dist = math.hypot(cx - pt[0], cy - pt[1])
                if dist < 25:
                    self.center_points[id] = (cx, cy)
                    objects_bbs_ids.append([x, y, w, h, id])
                    same_object_detected = True
                    break
            if not same_object_detected:
                self.center_points[self.id_count] = (cx, cy)
                objects_bbs_ids.append([x, y, w, h, self.id_count])
                self.id_count += 1

        new_center_points = {}
        for obj_bb_id in objects_bbs_ids:
            _, _, _, _, object_id = obj_bb_id
            center = self.center_points[object_id]
            new_center_points[object_id] = center
        self.center_points = new_center_points.copy()
        return objects_bbs_ids

tracker = EuclideanDistTracker()
min_width = 10
min_height = 10




cap = cv2.VideoCapture("highway_traffic.mp4")

# Check if camera opened successfully
if (cap.isOpened()== False):
    print("Error opening video file")

# Create tracker object
tracker = EuclideanDistTracker()

backeraser=cv2.createBackgroundSubtractorMOG2()#(history=100, varThreshold=40);
# Read until video is completed
while(cap.isOpened()):

# Capture frame-by-frame
    ret, frame = cap.read()
    if ret == True:
   #Show the image with matplotlib
        frame=cv2.resize(frame,(320,240));
        mask=backeraser.apply(frame);
        #plt.imshow(frame)
        #plt.show()
        # Extract Region of interest
        #roi = frame[340: 720,500: 800]


        _, mask = cv2.threshold(mask, 254, 255, cv2.THRESH_BINARY)
        contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
        detections = []
        for cnt in contours:
          # Calculate area and remove small elements
          area = cv2.contourArea(cnt)
          if area > 100:
              #cv2.drawContours(roi, [cnt], -1, (0, 255, 0), 2)
              x, y, w, h = cv2.boundingRect(cnt)
              detections.append([x, y, w, h])

              # 2. Object Tracking
          boxes_ids = tracker.update(detections)
          for box_id in boxes_ids:
            x, y, w, h, id = box_id
            cv2.putText(frame, str(id), (x, y - 15), cv2.FONT_HERSHEY_PLAIN, 2, (255, 0, 0), 2)
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 3)
            







        # Press Q on keyboard to exit

        jcv2.imshow("Frame",frame)
    if jcv2.waitKey(25) & 0xFF == ord('q'):
      break



# When everything done, release
# the video capture object
cap.release()

# Closes all the frames
jcv2.destroyAllWindows()


