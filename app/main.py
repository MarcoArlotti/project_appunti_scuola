from flask import Blueprint, flash, redirect, render_template, request, url_for
from app.repositories.crud import *
bp = Blueprint("main",__name__)

@bp.route("/")
def index():
    return render_template("home.html")

@bp.route("/utente/<int:id>")
def user(id):
    user = user_by_id(id)
    print(user)
    return render_template("utente.html", user=user)