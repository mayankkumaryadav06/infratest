object = {"a":{"b":{"c":{"d":["e",4]}}}}

final_key_output = ""
final_value_output = ""
def all_keys_without_yield(dict_obj):
    global final_key_output
    global final_value_output
    for key , value in dict_obj.items():
        if len(final_key_output) == 0:
            final_key_output = str(key)
        else:
            final_key_output = final_key_output + "/" + str(key)
        if isinstance(value, dict):
            all_keys_without_yield(value)
        else :
            final_value_output = value

all_keys_without_yield(object)
print(final_key_output)
print(final_value_output)
