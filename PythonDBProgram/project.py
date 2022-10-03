import sqlite3
from bokeh.io import output_file, show
from bokeh.plotting import figure
db = sqlite3.connect('project.db')
cur = db.cursor()
def initializeDB():
    try:
        f = open("queries.sql", "r")
        commandstring = ""
        for line in f.readlines():
            commandstring+=line
        cur.executescript(commandstring)
    except sqlite3.OperationalError:
        print("Database exists, skip initialization")
    except:
        print("No SQL file to be used for initialization") 


def main():
    initializeDB()
    userInput = -1
    while(userInput != "0"):
        print("\nMenu options:")
        print("1: Print Pizzas")
        print("2: Print all orders price that cost more than 20")
        print("3: Print all pizzas that have salami")
        print("4: Search for one customer")
        print("5: Print all employyes who didnt finish their order")
        print("6: Add a new ingredient")
        print("7: Update customers address")
        print("8: Bokeh Chart showing pizza prices")
        print("0: Quit")
        userInput = input("What do you want to do? ")
        print(userInput)
        if userInput == "1":
            printPizzas()
        if userInput == "2":
            printOver20()
        if userInput == "3":
            printSalamiPizzas()
        if userInput == "4":
            searchCustomer()
        if userInput == "5":
            printEmployees()
        if userInput == "6":
            addIngredient()
        if userInput == "7":
            updateCustomer()
        if userInput == "8":
            bokehVisual()
        if userInput == "0":
            print("Ending software...")
    db.close()        
    return


def printPizzas():
    print("Printing pizzas")
    cur.execute("SELECT Name FROM PizzaName;")
    results = cur.fetchall()
    for row in results:
      print(row)
    return

def printOver20():
    print("Printing prices that cost were more than 20")
    cur.execute("SELECT TotalPrice FROM Receipt WHERE TotalPrice > 20")
    results = cur.fetchall()
    for row in results:
      print(row)
    return

def printSalamiPizzas():
    print("Printing pizzas")
    cur.execute("SELECT DISTINCT p.[Name] FROM PizzaName AS p INNER JOIN PizzaNeeds AS pn ON p.PizzaID = pn.PizzaID INNER JOIN Ingredient AS i ON pn.IngredientID = 5002;")
    results = cur.fetchall()
    for row in results:
      print(row)
    return

def searchCustomer():
    customerName = input("What is the customer ID? ")
    cur.execute("SELECT * FROM Customer WHERE CustomerID = (?);", (customerName,))
    oneRow = cur.fetchone()
    print("ID: " + str(oneRow[0]))
    print("Email: " + str(oneRow[1]))
    print("Address: " + str(oneRow[2]))
    print("Phone number: " + str(oneRow[3]))
    return

def printEmployees():
    print("Printing employyes who didnt finish the order")
    cur.execute("SELECT FirstName FROM Employee AS e INNER JOIN PizzaOrder AS po ON E.EmployeeID = po.EmployeeID WHERE po.Status = 0;")
    results = cur.fetchall()
    for row in results:
      print(row)
    return

def addIngredient():
    ingredientPrice = input("What is the price of the ingredient?")
    ingredientName = input("What is the name of the ingredient?")
    cur.execute("INSERT INTO Ingredient (Price, Name) VALUES((?), (?));", (ingredientPrice, ingredientName,))
    db.commit()
    return


def updateCustomer():
    customerID = input("What is the customer's ID?")
    customerAddress = input("What is the customer's new address?")
    cur.execute("UPDATE Customer SET Address = (?) WHERE CustomerID = (?);", (customerAddress, customerID,))
    db.commit()
    return

def bokehVisual():
    output_file("pizzas.html")
    pizzas = []
    prices = []
    for row in cur.execute("SELECT DISTINCT PizzaName.Name, Pizza.Price FROM PizzaName INNER JOIN Pizza ON PizzaName.PizzaID = Pizza.PizzaID;"):
        pizzas.append((row[0]))
        prices.append((row[1]))
    p = figure(x_range=pizzas, height=250, title="Pizza prices",
           toolbar_location=None, tools="")
    p.vbar(x=pizzas, top=prices, width=0.9)
    p.xgrid.grid_line_color = None
    p.y_range.start = 0
    show(p)
    return

main()