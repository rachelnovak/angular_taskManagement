import { Component, OnInit } from '@angular/core';
import { Subscription, Observable } from 'rxjs';



@Component({
  selector: 'app-timer',
  templateUrl: './timer.component.html',
  styleUrls: ['./timer.component.css']
})
export class TimerComponent implements OnInit {

  ticks = 0;
    
  minutesDisplay: number = 0;
  hoursDisplay: number = 0;
  secondsDisplay: number = 0;

  sub: Subscription;

  ngOnInit() {
      this.startTimer();
  }

  private startTimer() {

    let timer = Observable.apply(2000,1000);
  
      this.sub = timer.subscribe(
          t => {
              this.ticks = t;
              
              this.secondsDisplay = this.getSeconds(this.ticks);
              this.minutesDisplay = this.getMinutes(this.ticks);
              this.hoursDisplay = this.getHours(this.ticks);
          }
      );
  }

  private getSeconds(ticks: number) {
      return this.pad(ticks % 60);
  }

  private getMinutes(ticks: number) {
       return this.pad((Math.floor(ticks / 60)) % 60);
  }

  private getHours(ticks: number) {
      return this.pad(Math.floor((ticks / 60) / 60));
  }

  private pad(digit: any) { 
      return digit <= 9 ? '0' + digit : digit;
  }


  // timer : number = 0;
  // intervalId : any;

  

  // start() {
  //   this.intervalId = setInterval(() => {
  //     this.timeIt()
  //   }, 1000);
  // }

  // stop() {
  //    clearInterval(this.intervalId);
  //    this.intervalId = -1;
  // }

  // startStop() {
  //   if(this.intervalId == -1) {
  //     this.start();
  //   }  else {
  //     this.stop();
  //   }
  // }

  // timeIt() {
  //  this.timer++;
  // }

  // ngOnInit() {
  //   this.start();
  // }

}
