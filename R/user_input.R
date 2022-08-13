
validate_user_input <- function(df, target_column, feature_columns) {

  if(is.character(target_column)) { }
  else {stop('Input target_column must be a base::character() type object.')}

  if(is.character(feature_columns)) { }
  else {stop('Input feature_columns must be a base::character() type object.')}

  if(length(feature_columns) > 1) { }
  else {stop('Input feature_columns should be a character vector-type object. This check only tests "length > 1".')}

}