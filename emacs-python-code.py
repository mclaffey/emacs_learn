x = 1
print("value is", x)
print("hello")

def my_func():
    """Keeps prompting user until the letter q
    """
    x = ""
    while x != "q":
        x = input("type a letter, q to quit: ")
        
    print("bye")

if __name__=='__main__':
    print("From main, starting my_func")
    my_func()
    
