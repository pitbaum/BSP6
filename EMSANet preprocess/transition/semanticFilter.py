from PIL import Image

# open prediction
pred = Image.open('pred2.png')
pred_data = pred.load()

# for each non black color, create an RGB value in the array of instances registered in the image
pred_height, pred_width = pred.size
instance_colors = []
for row in range(pred_height):
    for col in range(pred_width):
        r,g,b,a = pred_data[row,col]
        # If not black, look if the color is already registered for instane colors
        # Already registered: pass
        # Not yet registered: append to array in format (r,g,b)
        if not (r == 0 and g == 0 and b == 0):
            is_item = False
            for item in instance_colors:
                if item[0] == r and item[1] == g and item[2] == b:
                   is_item = True
            if is_item == False:
                instance_colors.append((r,g,b))
                
print("--------------------came here--------------------")
print(instance_colors)

height,width = pred.size
# For each instance create a new file that shows the ground truth mapping of that instance part
image_name = "\objectwiseGT"
image_count_name = 0
for item in instance_colors:
    # Open ground truth image
    image = Image.open('gt2.png')
    # For each instance load the gt data new
    image_data = image.load()
    image_count_name += 1
    name = image_name + str(image_count_name) + ".png"
    # current instances rgb color from the segmented image
    i_r = item[0]
    i_g = item[1]
    i_b = item[2]
    print("current_images rgb that needs to be checked",i_r,i_g,i_b)
    for row in range(height):
        for col in range(width):
            r,g,b,a = pred_data[row,col]
            if not (r == i_r and i_b == b and i_g == g):
                image_data[row,col] = 255,255,255
    
    image.save(".\processed_objects2" + name)
    print("saved image ", name)
            
print("Finished")
