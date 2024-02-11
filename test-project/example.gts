import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';

const two: number = 2;

class Foo extends Compnent {
  <template>
    {{this.num}}

    <button {{on 'click' this.increment}}
      click me
    </button>
  </template>

  @tracked num = this.args.starting;

  increment = () => this.num++;
}

<template>
  <Foo @starting={{two}} />
</template>
