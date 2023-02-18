from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user
from flask_mail import Mail
import json



# MY db connection
local_server= True
app = Flask(__name__)
app.secret_key='aneeqah'


# this is for getting unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'

# SMTP MAIL SERVER SETTINGS

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME="add your gmail-id",
    MAIL_PASSWORD="add your gmail-password"
)
mail = Mail(app)


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))




# app.config['SQLALCHEMY_DATABASE_URL']='mysql://username:password@localhost/databas_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/rdbms'
db=SQLAlchemy(app)



# here we will create db models that is tables
class Test(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100))
    email=db.Column(db.String(100))

class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    usertype=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))

class Mahilas(db.Model):
    pid=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    scheme=db.Column(db.String(50))
    amount=db.Column(db.String(50))
    business=db.Column(db.String(50))
    time=db.Column(db.String(50),nullable=False)
    date=db.Column(db.String(50),nullable=False)
    sect=db.Column(db.String(50))
    number=db.Column(db.String(50))

class Financers(db.Model):
    did=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    financername=db.Column(db.String(50))
    sect=db.Column(db.String(50))

class Trigr(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    pid=db.Column(db.Integer)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    action=db.Column(db.String(50))
    timestamp=db.Column(db.String(50))





# here we will pass endpoints and run the fuction
@app.route('/')
def index():
    return render_template('index.html')
    


@app.route('/financers',methods=['POST','GET'])
def financers():

    if request.method=="POST":

        email=request.form.get('email')
        financername=request.form.get('financername')
        sect=request.form.get('sect')

        query=db.engine.execute(f"INSERT INTO `financers` (`email`,`financername`,`sect`) VALUES ('{email}','{financername}','{sect}')")
        flash("Information is Stored","primary")

    return render_template('financer.html')



@app.route('/mahilas',methods=['POST','GET'])
@login_required
def mahila():
    doct=db.engine.execute("SELECT * FROM `financers`")

    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        scheme=request.form.get('scheme')
        amount=request.form.get('amount')
        business=request.form.get('business')
        time=request.form.get('time')
        date=request.form.get('date')
        sect=request.form.get('sect')
        number=request.form.get('number')
        subject="MAHILA SHAKTI KENDRA"
        query=db.engine.execute(f"INSERT INTO `mahilas` (`email`,`name`,	`scheme`,`amount`,`business`,`time`,`date`,`sect`,`number`) VALUES ('{email}','{name}','{scheme}','{amount}','{business}','{time}','{date}','{sect}','{number}')")

# mail starts from here

        # mail.send_message(subject, sender=params['gmail-user'], recipients=[email],body=f"YOUR bOOKING IS CONFIRMED THANKS FOR CHOOSING US \nYour Entered Details are :\nName: {name}\nSlot: {slot}")



        flash("Booking Confirmed","info")


    return render_template('mahila.html',doct=doct)


@app.route('/bookings')
@login_required
def bookings(): 
    em=current_user.email
    if current_user.usertype=="Financer":
        query=db.engine.execute(f"SELECT * FROM `mahilas`")
        return render_template('booking.html',query=query)
    else:
        query=db.engine.execute(f"SELECT * FROM `mahilas` WHERE email='{em}'")
        return render_template('booking.html',query=query)
    


@app.route("/edit/<string:pid>",methods=['POST','GET'])
@login_required
def edit(pid):
    posts=Mahilas.query.filter_by(pid=pid).first()
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        scheme=request.form.get('scheme')
        amount=request.form.get('amount')
        business=request.form.get('business')
        time=request.form.get('time')
        date=request.form.get('date')
        sect=request.form.get('sect')
        number=request.form.get('number')
        db.engine.execute(f"UPDATE `mahilas` SET `email` = '{email}', `name` = '{name}', `scheme` = '{scheme}', `amount` = '{amount}', `business` = '{business}', `time` = '{time}', `date` = '{date}', `sect` = '{sect}', `number` = '{number}' WHERE `patients`.`pid` = {pid}")
        flash("Slot is Updates","success")
        return redirect('/bookings')
    
    return render_template('edit.html',posts=posts)


@app.route("/delete/<string:pid>",methods=['POST','GET'])
@login_required
def delete(pid):
    db.engine.execute(f"DELETE FROM `mahilas` WHERE `mahilas`.`pid`={pid}")
    flash("Slot Deleted Successful","danger")
    return redirect('/bookings')






@app.route('/signup',methods=['POST','GET'])
def signup():
    if request.method == "POST":
        username=request.form.get('username')
        usertype=request.form.get('usertype')
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()
        if user:
            flash("Email Already Exist","warning")
            return render_template('/signup.html')
        encpassword=generate_password_hash(password)

        new_user=db.engine.execute(f"INSERT INTO `user` (`username`,`usertype`,`email`,`password`) VALUES ('{username}','{usertype}','{email}','{encpassword}')")

        # this is method 2 to save data in db
        # newuser=User(username=username,email=email,password=encpassword)
        # db.session.add(newuser)
        # db.session.commit()
        flash("Signup Succes Please Login","success")
        return render_template('login.html')

          

    return render_template('signup.html')

@app.route('/login',methods=['POST','GET'])
def login():
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()

        if user and check_password_hash(user.password,password):
            login_user(user)
            flash("Login Success","primary")
            return redirect(url_for('index'))
        else:
            flash("invalid credentials","danger")
            return render_template('login.html')    





    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Logout SuccessFul","warning")
    return redirect(url_for('login'))



@app.route('/test')
def test():
    try:
        Test.query.all()
        return 'My database is Connected'
    except:
        return 'My db is not Connected'
    

@app.route('/details')
@login_required
def details():
    # posts=Trigr.query.all()
    posts=db.engine.execute("SELECT * FROM `trigr`")
    return render_template('trigers.html',posts=posts)


@app.route('/search',methods=['POST','GET'])
@login_required
def search():
    if request.method=="POST":
        query=request.form.get('search')
        sect=Financers.query.filter_by(sect=query).first()
        name=Financers.query.filter_by(financername=query).first()
        if name:

            flash("Financer is Available","info")
        else:

            flash("Financer is Not Available","danger")
    return render_template('index.html')






app.run(debug=True)    

