library(stringr)

datas = read.csv("/Assignment for R.txt")
class(datas)
is.object(datas[1])

# Location from which actual data starts
numeric_data = datas[29:2483,]
# Location of Column names
head_data = datas[27,]

message("Total Data in Dataset", length(numeric_data))

fileConn = file("output.txt")
writeLines(as.character(numeric_data), fileConn)
close(fileConn)

read_data = read.fwf("output.txt",
                     widths = c(5,5,3,3,4,3,5,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3))

mtx_head = str_split(head_data, "\\s+", simplify = T)
names(read_data) = as.character(mtx_head)
read_data = read_data[,-c(12,23)]

sum(is.na.data.frame(read_data))

df_h3 = read_data[read_data$HR==3,]
df_h12 = read_data[read_data$HR==12,]

remove_na = function(df, col){
  month = split.data.frame(df, f=col)
  for(i in 1:length(month)){
    for(j in 1:(length(mtx_head)-2)){
      na = sum(is.na.data.frame(month[[i]][[mtx_head[j]]]))
      if(na > 0){
        missing_index = which(is.na(month[[i]][[mtx_head[j]]]))
        for(k in missing_index){
          month[[i]][[mtx_head[j]]][k] = mean(month[[i]][[mtx_head[j]]], na.rm = T)
        } 
      }
    }
  }
  return(unsplit(month, f=col))
}

message("Total NA Values ", sum(is.na.data.frame(read_data)))

message("Before NA Removal of Hour 3: ", sum(is.na.data.frame(df_h3)))
df_h3 = remove_na(df_h3, df_h3$MN)
message("After NA Removal of Hour 3: ", sum(is.na.data.frame(df_h3)))

message("Before NA Removal of Hour 12: ", sum(is.na.data.frame(df_h12)))
df_h12 = remove_na(df_h12, df_h12$MN)
message("After NA Removal of Hour 12: ", sum(is.na.data.frame(df_h12)))
